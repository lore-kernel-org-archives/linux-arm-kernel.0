From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 Mar 2017 10:22:12 +0200
Subject: [PATCH v9 12/12] ARM: EXYNOS: refactor of mach-exynos to use
 chipid information
In-Reply-To: <69ac19c2-76de-d614-492b-ccdc83d01d81@samsung.com>
References: <CGME20170330131444epcas5p45051cf7e6ec7a993c2c9f84254b89a19@epcas5p4.samsung.com>
 <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
 <1490879826-16754-13-git-send-email-pankaj.dubey@samsung.com>
 <CAK8P3a2oK1MvWe4B-4r2Rt7Q87juNJd3MsetN8-OeDYhBmKyUg@mail.gmail.com>
 <69ac19c2-76de-d614-492b-ccdc83d01d81@samsung.com>
Message-ID: <CAK8P3a1GobLFjVXySXHGYBXscMaTcL8nzv183Reho87+U3Z5cA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 31, 2017 at 8:01 AM, pankaj.dubey <pankaj.dubey@samsung.com> wrote:
> On Thursday 30 March 2017 07:31 PM, Arnd Bergmann wrote:
>> On Thu, Mar 30, 2017 at 3:17 PM, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
>>
>> This seems really overcomplicated. From what I can tell, this is only needed
>> to find the SCU address, but there are better ways to do that, either by
>> looking up the SCU in the DT at the time you actually need it,
>> or by calling scu_a9_get_base().
>
> Indeed it's complicated and ugly, for the same reason I attempted to
> clean-up this part for Exynos SoC in patch series [1], which was
> accepted by Samsung maintainer Krzysztof and later during pull request
> rejected by ARM maintainers [2]
>
> [1]: https://www.spinics.net/lists/arm-kernel/msg540498.html
> [2]: http://lkml.iu.edu/hypermail/linux/kernel/1612.0/01508.html
>
> Given the argument we can't adopt getting base address of SCU completely
> via DT without breaking OLD dtbs at some point, difficult to simplify
> these stuffs.
>
> Please guide which is the best way to handle such stuffs.
>
> In fact I made another attempt [3] to cleanup this SCU related stuffs
> for other ARM based platforms, but we could not arrive on some consensus
> at that time. I will try to attempt it again soon.
>
> [3]: http://www.spinics.net/lists/arm-kernel/msg542351.html

I very much appreciate your attempts, this is very helpful. I'm sorry
for making it so hard for you. I had remembered your previous series,
but did not realize that you were the author of both this patch and
the SCU cleanup.

Let me try to understand the entire problem space better. These
are my assumptions based on what  you write:

- A clean solution would be to map the SCU based on the DT as
  you implemented in the earlier patch series, but that breaks
  running new kernels with old DTBs, which we don't want.

- Another clean solution would be to map the SCU based on
  scu_a9_get_base(), but that doesn't work on all variants of
  exynos4, because there is at least one (which?) that has incorrect
  data in the register

- The approach in this patch works, but is really ugly as it
  requires parsing the fdt.

Assuming that we don't want any of the approaches above,
here are some other ideas that might be a little better:

- Map the SCU later, just before we first need for calling
  scu_enable(): exynos_smp_prepare_cpus(),
  exynos_enter_aftr() or exynos_pm_resume(). All three
  are late enough that we can simply call ioremap()
  on the known physical address for the first caller,
  and they are all guarded by a
  ARM_CPU_PART_CORTEX_A9 check that should
  be equivalent to the EXYNOS4 check you have.

- Split the exynos4 machine descriptor from the one
  for exynos5, and exynos3, the call the iotable_init
  unconditionally for exynos4. The same method would
  also let us get rid of some of the other
  of_machine_is_compatible() checks.

       Arnd
