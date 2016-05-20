From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 20 May 2016 11:14:03 +0200
Subject: [PATCH V7 00/11] Support for generic ACPI based PCI host
 controller
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1EDAF6AC@lhreml503-mbs>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ED8DF51@lhreml503-mbs>
 <57331290.7070104@semihalf.com>
 <3d4aae09-51c4-f007-5100-191a4a85e27a@redhat.com>
 <CAKv+Gu8fdeJ9OvRSmtu9zyvcjK3O-4WU=jG=6-7t4xZwvV8d2g@mail.gmail.com>
 <95b1d06e-f9c5-39f3-1003-f536b65eef60@redhat.com>
 <CAKv+Gu-_xp_t_Ze3Pw_-82-fmy=tCy-h=4FbP98eLbuXVk2hHQ@mail.gmail.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1EDAF6AC@lhreml503-mbs>
Message-ID: <CAKv+Gu_zpoFsDr7e8zPCDKPpRdKDVH+vnC0nfvmGaJ7xcP3Zng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 May 2016 at 10:40, Gabriele Paoloni <gabriele.paoloni@huawei.com> wrote:
> Hi Ard
>
>> -----Original Message-----
>> From: Ard Biesheuvel [mailto:ard.biesheuvel at linaro.org]
[...]
>>
>> Is the PCIe root complex so special that you cannot simply describe an
>> implementation that is not PNP0408 compatible as something else, under
>> its own unique HID? If everybody is onboard with using ACPI, how is
>> this any different from describing other parts of the platform
>> topology? Even if the SBSA mandates generic PCI, they already deviated
>> from that when they built the hardware, so pretending that it is a
>> PNP0408 with quirks really does not buy us anything.
>
> From my understanding we want to avoid this as this would allow each
> vendor to come up with his own code and it would be much more effort
> for the PCI maintainer to rework the PCI framework to accommodate X86
> and "all" ARM64 Host Controllers...
>
> I guess this approach is too risky and we want to avoid this. Through
> standardization we can more easily maintain the code and scale it to
> multiple SoCs...
>
> So this is my understanding; maybe Jon, Tomasz or Lorenzo can give
> a bit more explanation...
>

OK, so that boils down to recommending to vendors to represent known
non-compliant hardware as compliant, just so that we don't have to
change the code to support additional flavors of ECAM ? It's fine to
be pragmatic, but that sucks.

We keep confusing the x86 case with the ARM case here: for x86, they
needed to deal with broken hardware *after* the fact, and all they
could do is find /some/ distinguishing feature in order to guess which
exact hardware they might be running on. For arm64, it is the opposite
case. We are currently in a position where we can demand vendors to
comply with the standards they endorsed themselves, and (ab)using ACPI
+ DMI as a de facto platform description rather than plain ACPI makes
me think the DT crowd were actually right from the beginning. It
*directly* violates the standardization principle, since it requires a
priori knowledge inside the OS that a certain 'generic' device must be
driven in a special way.

So can anyone comment on the feasibility of adding support for devices
with vendor specific HIDs (and no generic CIDs) to the current ACPI
ECAM driver in Linux?
