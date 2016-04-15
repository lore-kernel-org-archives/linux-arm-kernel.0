From: peda@axentia.se (Peter Rosin)
Date: Fri, 15 Apr 2016 21:47:33 +0000
Subject: atmel-ssc-dai problem with ssc1
Message-ID: <AM4PR02MB1299422D2DC235E7852C9C19BC680@AM4PR02MB1299.eurprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I have problems using the sound/soc/atmel/atmel_ssc_dai.c driver with
ssc1 on a board derived from the at91sam9261ek board. We use a different
audio codec and we use ssc1 instead of ssc0, but that really should not
matter. But it does.

I have copied shamelessly from the sound/soc/atmel/atmel_wm8904.c card
driver, with one of the changes showing a big problem in the atmel_ssc_dai
driver. I call atmel_ssc_set_audio(1) where atmel_wm8904.c calls
atmel_ssc_set_audio(0). Well, both call a value given from dt, but the
dts using the atmel_wm8904 driver all use ssc0 and my dts uses ssc1.

It turns out that all the dai devices registered by atmel_ssc_dai end
up with id 0, which does not work at all in e.g.
atmel_ssc_dai.c:atmel_ssc_startup() which is using dai->id as index
into the ssc_info[] array and therefore looks at index 0 when the setup
by atmel_ssc_set_audio(1) had stored the needed stuff at index 1.

This leads to a NULL dereference, such as:

Unable to handle kernel NULL pointer dereference at virtual address 0000000c
pgd = c1bf8000
[0000000c] *pgd=218e9831, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1] ARM
Modules linked in:
CPU: 0 PID: 517 Comm: aplay Not tainted 4.1.0+ #20
Hardware name: Atmel AT91SAM9
task: c19e3180 ti: c1bee000 task.ti: c1bee000
PC is at atmel_ssc_startup+0x1c/0x14c
LR is at soc_pcm_open+0xd4/0x7c8
pc : [<c030155c>]    lr : [<c02f8e0c>]    psr: a0000013
sp : c1befcd8  ip : c1a08ab8  fp : 00000000
r10: c1a0fc00  r9 : c1beff74  r8 : 00000000
r7 : c0597d50  r6 : c19b5c00  r5 : c19b5c00  r4 : c0597d50
r3 : 00000000  r2 : 00000000  r1 : c1a065e0  r0 : c19b5c00
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005317f  Table: 21bf8000  DAC: 00000015
Process aplay (pid: 517, stack limit = 0xc1bee190)
Stack: (0xc1befcd8 to 0xc1bf0000)
fcc0:                                                       c19b5c00 c1a065e0
fce0: 00000000 c0301540 c19b6810 c19b5c00 c1a065e0 00000001 00000000 c1beff74
fd00: c1a0fc00 c02f8e0c c1a0fc00 00000000 ffffffff 00000011 c19ab400 000f4240
fd20: 00000009 c02e4d90 000f4240 c19b681c 0000000b ffffffff 00000000 c1befd8c
fd40: 00000000 c19b7f88 c19b7f94 00000000 c1beff74 00000000 00000000 c02e4e00
fd60: c19b7c00 c19b5c00 c1a375c0 c19b7c00 c1a375c0 c02e4ee4 00000000 c19e3180
fd80: c002f938 c19b7f94 c19b7f94 c19b7c00 00000010 c19b7c00 c1a375c0 00000000
fda0: c1a22ce0 07400010 c1977000 c02e50b0 c0408f30 c1a375c0 c198b8b8 c02d8e54
fdc0: c198b8b8 c1a375c0 c191e680 00000000 c0408a40 c0087784 c198b8b8 00000010
fde0: c1a375c0 c198b8b8 c008767c c1a375c8 c1a375c0 c0082f6c c1befef0 c1a375c0
fe00: c1befeb4 c1befebc c1a375c0 c008fe94 00000037 c1be34a8 b6f10000 ffffffff
fe20: 00000000 00000000 00020802 c1be34a8 c198bc60 00000000 c1414c38 00000000
fe40: 00000041 00000026 00000000 00000000 c1977000 00500088 c1977000 c008df24
fe60: 00000000 00500088 c1befe98 c00809e0 c198b8b8 00000002 00000040 c1befef0
fe80: c1a375c0 c1beff74 ffffff9c 00000000 c1bee000 c1977000 00000041 c0090270
fea0: c1befebc c1977000 c1a32d00 c02dd728 c1b527d4 c1ad4030 c1417198 00000000
fec0: 00000054 c1beff74 00000001 ffffff9c c1befef0 c1977000 c1bee000 00000000
fee0: 00000000 c00905e4 00000041 00000005 c1ad4030 c1417198 c4254b62 00000008
ff00: c1977019 be82833c 00000000 c1440bb0 c198b8b8 00000101 00000004 00000040
ff20: 00000000 00000000 00000000 00000000 c1b39020 00000000 00000400 c1bc5660
ff40: 000a0802 c009ad10 000a0802 ffffff9c 00000004 ffffff9c c1977000 00000005
ff60: c000a384 c0082b94 00000000 c1a37660 c1a37660 00020802 40040000 00000026
ff80: 00000100 00000001 0002c6f8 be82848c 00000000 ffffffff 00000005 c000a384
ffa0: 00000000 c000a200 be82848c 00000000 be82848c 000a0802 00000000 00000000
ffc0: be82848c 00000000 ffffffff 00000005 00000000 00000000 00000001 00000000
ffe0: b6f9cee4 be828328 b6f33284 b6e1bccc 60000010 be82848c 21ffd831 21ffdc31
[<c030155c>] (atmel_ssc_startup) from [<c02f8e0c>] (soc_pcm_open+0xd4/0x7c8)
[<c02f8e0c>] (soc_pcm_open) from [<c02e4e00>] (snd_pcm_open_substream+0x48/0x90)
[<c02e4e00>] (snd_pcm_open_substream) from [<c02e4ee4>] (snd_pcm_open+0x9c/0x1cc)
[<c02e4ee4>] (snd_pcm_open) from [<c02e50b0>] (snd_pcm_playback_open+0x40/0x5c)
[<c02e50b0>] (snd_pcm_playback_open) from [<c02d8e54>] (snd_open+0x128/0x148)
[<c02d8e54>] (snd_open) from [<c0087784>] (chrdev_open+0x108/0x12c)
[<c0087784>] (chrdev_open) from [<c0082f6c>] (do_dentry_open+0x1bc/0x2d0)
[<c0082f6c>] (do_dentry_open) from [<c008fe94>] (do_last+0x930/0xb58)
[<c008fe94>] (do_last) from [<c0090270>] (path_openat+0x1b4/0x4f8)
[<c0090270>] (path_openat) from [<c00905e4>] (do_filp_open+0x30/0x7c)
[<c00905e4>] (do_filp_open) from [<c0082b94>] (do_sys_open+0x124/0x1c4)
[<c0082b94>] (do_sys_open) from [<c000a200>] (ret_fast_syscall+0x0/0x38)
Code: e3a0403c e0247493 e5943004 e1a06000 (e593300c)
---[ end trace edfb18e35da5cede ]---

I'm fairly confident that this comes from the line
	clk_enable(ssc_p->ssc->clk);
in atmel_ssc_startup() when ssc_p->ssc is NULL.

Looking further, the function that selects id 0 is fmt_single_name() in
sound/soc/soc-core.c which would have found individual ids for the three
ssc devices if they would have had names like "fffbc000.ssc.0",
"fffc0000.ssc.1" and "fffc4000.ssc.2" instead of plain "fffbc000.ssc" etc
(i.e. w/o the needed trailing .#) which is what they do have as dev_name.

I can force sound to work on my board by installing the below revolting
patch (there is only one dai in use with legacy dai naming) which is
a pretty good indicator that my analysis is correct.

The atmel_ssc_dai driver really should make sure that the dais it registers
end up with the correct id. Or, it could be the case that at91sam9261.dtsi
is at fault for giving the ssc:s bad names, but something is clearly not
working as intended.

BTW, I'm on d034050b9d4d3d73 on the linux-4.1-at91 branch (nov 2015) of
the linux4sam/linux-at91.git tree at github, plus a bunch of local patches.

Cheers,
Peter

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2373252..671a63e 100644 (file)
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2601,6 +2601,8 @@ static int snd_soc_register_dais(struct snd_soc_component *component,
                 */
                if (count == 1 && legacy_dai_naming) {
                        dai->name = fmt_single_name(dev, &dai->id);
+                       /* uurk, force id 1 since we use ssc1 */
+                       dai->id = 1;
                } else {
                        dai->name = fmt_multiple_name(dev, &dai_drv[i]);
                        if (dai_drv[i].id)
