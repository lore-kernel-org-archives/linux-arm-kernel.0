From: andrea.adami@gmail.com (Andrea Adami)
Date: Thu, 4 Jan 2018 19:19:45 +0100
Subject: v4.14.9 on ARMv5: OK with gcc 4.8/5.4, NOK with gcc 7.2
In-Reply-To: <20180104171637.GP28752@n2100.armlinux.org.uk>
References: <20180104180238.581b202c@windsurf.lan>
 <20180104171637.GP28752@n2100.armlinux.org.uk>
Message-ID: <CAAQYJAuwE9n-M7pcpJL53JLVY0PmO721mHh7aZ5KkCoYTzdRMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 4, 2018 at 6:16 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Thu, Jan 04, 2018 at 06:02:38PM +0100, Thomas Petazzoni wrote:
>> Hello,
>>
>> I'm pretty sure it has already been reported, but just in case: I'm
>> testing v4.14.9 on an ARMv5 platform (Kirkwood-based OpenBlocks A7).
>> mvebu_v5_defconfig boots fine when built with gcc 4.8 (good old
>> Sourcery toolchain) or gcc 5.4 (some old Linaro toolchain), but doesn't
>> boot at all when built with gcc 7.2 (Fedora toolchain). Even when
>> configured and booted with earlyprintk, the kernel doesn't say anything.
>>
>> The toolchain being used is the default ARM toolchain provided by
>> Fedora 27. It says:
>>
>> gcc version 7.2.1 20170915 (Red Hat Cross 7.2.1-1) (GCC)
>> GNU ld version 2.29.1-1.fc27
>>
>> So it's quite bleeding edge.
>>
>> Let me know if this has already been fixed, or if I should test a
>> patch. I have not tested 4.15-rc or next at this point, assuming that
>> if a fix had been made, it would have been backported to 4.14-stable.
>
> It's a known issue -
>
> http://archive.armlinux.org.uk/lurker/message/20171018.095713.a56a717b.en.html
>
> but so far no patches have been forthcoming for the kernel, because
> (I guess) it's deemed to be a gcc bug.
>
> It's one of those discussions that just seemed to die without any
> real conclusion.
>
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
> According to speedtest.net: 8.21Mbps down 510kbps up
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


I am happy to report the gcc bug has been fixed in trunk.
I am as well dubious where they say this should also fix gcc6 where we
have no known issues with gcc6.

"
This should also fix
incorrect generation of ldrd/strd with unaligned accesses that could
previously have occurred on ARMv5e where all such operations must be
64-bit aligned."

https://github.com/gcc-mirror/gcc/commit/f59996b56aaa1c1d62a16cbb4010775b624cbde0

In OpenEmbedded we backported the patch a while ago, see the
discussion about qemu booting where real hw doesn't:
http://lists.openembedded.org/pipermail/openembedded-core/2017-November/144045.html


Regards
Andrea
