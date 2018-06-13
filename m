From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 13 Jun 2018 14:36:07 -0700
Subject: [PATCH 2/4] ARM: Introduce ability to enable invalidate of BTB
 with ICIALLU on Cortex-A15 for CVE-2017-5715
In-Reply-To: <20180613133704.dwytvpj3zeuywooh@kahuna>
References: <20180612202411.29798-1-nm@ti.com>
 <20180612202411.29798-3-nm@ti.com>
 <6BFD98F8-FACB-43DE-82DC-E0A134D4E1C0@gmail.com>
 <20180613133704.dwytvpj3zeuywooh@kahuna>
Message-ID: <2786d17e-1075-e0fb-1864-fb5900e4a2af@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2018 06:37 AM, Nishanth Menon wrote:
> On 00:30-20180613, Florian Fainelli wrote:
>> On June 12, 2018 1:24:09 PM PDT, Nishanth Menon <nm@ti.com> wrote:
>>> As recommended by Arm in [1], ACTLR[0] (Enable invalidates of BTB)
>>> needs to be set[2] for BTB to be invalidated on ICIALLU. This needs to
>>> be done unconditionally for Cortex-A15 processors. Provide a config
>>> option for platforms to enable this option based on impact analysis
>>> for products.
>>>
>>> NOTE: This patch in itself is NOT the final solution, this requires:
>>> a) Implementation of v7_arch_cp15_set_acr on SoCs which may not
>>>   provide direct access to ACR register.
>>> b) Operating Systems such as Linux to provide adequate workaround in
>>> the
>>>   right locations.
>>
>> This is the case as of 4.18 so you could probably reference CONFIG_CPU_SPECTRE and CONFIG_HARDEN_BRANCH_PREDICTOR in a v2.
> 
> Did'nt want to tie the description too deep to Linux specifics.. Linux
> documents itself and users are encouraged to read that documentation,
> correct?

That's fair enough I guess, we also don't know how the other OSes do
provide that mitigation and whether they have run-time/build-time
configuration options gating those.

> 
>>
>>> c) This workaround applies to only the boot processor. It is important
>>>   to apply workaround as necessary (context-save-restore) around low
>>>   power context loss OR additional processors as necessary in either
>>>   firmware support OR elsewhere in OS.
>>
>> About that, I don't know enough of uboot but are there existing PSCI or
>> other seemingly standard secondary core support in uboot that would make
>> us go through the same initialization as the boot CPU? If not, is
>> everything going to be largely implementation specific and
>> scattered between uboot and the hypervisors or kernel?
> 
> in ARMV7 SoCs, unfortunately, we lived in a world of no-exact-standard.
> even within TI, Few of the SoCs use PSCI, others did implement custom
> SMC calls (since they existed in an architecture prior to PSCI).
> 
>>
>> FWIW, this is what prompted me to submit this:
>>
>> https://patchwork.kernel.org/patch/10453643/
> 
> That wont work in a generic manner for precisely the same reason I had to do
> it with weak function in u-boot (some SoCs will only permit 'mcr
> p15, 0, r0, c1, c0, 1' in secure world and you need to make a custom smc
> call to make it happen). Unfortunately, IMHO, at least at this
> point, there'd be custom implementations per SoC and layers depending on
> where to implement it.

It won't work in a generic manner but it will work for some platforms
where updating the firmware is impractical, and since the bits are write
ignore if your PL does not allow it, this still seems like a net win for
platforms where this is effective, and it does take care of Linux doing
the SMP bring-up of secondary cores as well. That's what we have in our
downstream tree at least, and I was hoping this could land upstream too.
-- 
Florian
