From: lars@metafoo.de (Lars-Peter Clausen)
Date: Wed, 31 Jul 2013 08:35:49 +0200
Subject: New dapm panic on beaver with next-20130730
In-Reply-To: <CAOesGMjqyF7zPoGsW6oBRFey7Bc_umnoGob7oQ=_c3n7oevuaQ@mail.gmail.com>
References: <CAOesGMig6jry1GJLoTnOqxom1KjtBTUtZz-_-SiZLpGTc3VkqA@mail.gmail.com>
 <51F8A933.4080708@metafoo.de>
 <CAOesGMjqyF7zPoGsW6oBRFey7Bc_umnoGob7oQ=_c3n7oevuaQ@mail.gmail.com>
Message-ID: <51F8B045.8030303@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2013 08:13 AM, Olof Johansson wrote:
> On Tue, Jul 30, 2013 at 11:05 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 07/31/2013 07:36 AM, Olof Johansson wrote:
>>>
>>> Hi Mark, Lars-Peter,
>>>
>>> I noticed the below panic on beaver (Tegra30). Seems like seaboard
>>> (Tegra20) is fine. This is with next-20130730, tegra_defconfig.
>>
>>
>> Hi,
>>
>> So the same machine driver with the same codec works on tegra2, but not on
>> tegra3? The crash doesn't seem to be directly related to the patch, but the
>> patch changed the memory layout. Is it possible that you still have a
>> outdated module that's being loaded on your tegra3 board?
>
> Sorry, I should have been cleared on that. Not at all the same codec,
> seaboard uses wm8903, beaver rt5640.
>
>> Can you add a few debugging printks and run the test again and paste the
>> last few lines before the crash:
>
> [beaver          00:18] [    4.045897] dapm_generic_check_power: IF2 ADC L
> [beaver          00:18] [    4.050417] dapm_clear_walk_output 1: ee3a7bc0
> [beaver          00:18] [    4.054845] dapm_generic_check_power: IF2 DAC
> [beaver          00:18] [    4.059193] dapm_clear_walk_output 1: ee3a8240
> [beaver          00:18] [    4.063621] dapm_clear_walk_output 1: ee3a8280
> [beaver          00:18] [    4.068048] dapm_generic_check_power: IF1 ADC R
> [beaver          00:18] [    4.072661] dapm_clear_walk_output 1: ee3a7c40
> [beaver          00:18] [    4.077091] dapm_generic_check_power: IF1 ADC L
> [beaver          00:18] [    4.081616] dapm_clear_walk_output 1: ee3a7c80
> [beaver          00:18] [    4.086045] dapm_generic_check_power: IF1 DAC
> [beaver          00:18] [    4.090394] dapm_clear_walk_output 1: ee3a82c0
> [beaver          00:18] [    4.094821] dapm_clear_walk_output 1: ee3a8300
> [beaver          00:18] [    4.099256] dapm_generic_check_power: INR Mux
> [beaver          00:18] [    4.103599] dapm_clear_walk_output 1: ee3af670
> [beaver          00:18] [    4.108026] dapm_generic_check_power: INL Mux
> [beaver          00:18] [    4.112375] dapm_clear_walk_output 1: ee3af5f0
> [beaver          00:18] [    4.116802] dapm_clear_walk_output 2: 6b6b6b6b

0x6b6b6b6b is poisoned freed memory. According to the source neither the INR 
Mux nor the INL Mux widget should have any sinks. Can you add a couple more 
printks:

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b779d36..1a82e75 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -774,8 +774,13 @@
  	struct snd_soc_dapm_path *p;

  	list_for_each_entry(p, sink, list_source) {
+		printk("dapm_clear_walk_output 1: %p\n", p);
  		if (p->walked) {
  			p->walked = 0;
+			printk("dapm_clear_walk_output 1: %p\n", p->source);
+			printk("dapm_clear_walk_output 2: %p\n", p->sink);
+			printk("dapm_clear_walk_output 3: %s\n",
+				p->sink->name);
  			dapm_clear_walk_output(dapm, &p->sink->sinks);
  		}
  	}
@@ -1189,6 +1194,8 @@
  	DAPM_UPDATE_STAT(w, power_checks);

+	printk("dapm_generic_check_power: %p %s\n", w, w->name);
+
  	in = is_connected_input_ep(w, NULL);
  	dapm_clear_walk_input(w->dapm, &w->sources);
  	out = is_connected_output_ep(w, NULL);
