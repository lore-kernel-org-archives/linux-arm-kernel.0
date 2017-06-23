From: roy.pledge@nxp.com (Roy Pledge)
Date: Fri, 23 Jun 2017 19:25:43 +0000
Subject: [GIT PULL v3] updates to qbman (soc drivers) to support arm/arm64
References: <HE1PR0401MB17071A7853695DB6546FE28C8FC50@HE1PR0401MB1707.eurprd04.prod.outlook.com>
 <CAK8P3a2EvCvs57hE_X9J5jg6jW8jPh6gxaTOUYntbnHdb_cMZA@mail.gmail.com>
 <20170623153839.GS4902@n2100.armlinux.org.uk>
Message-ID: <DB6PR04MB2999B4C383B2A33A3370B72986D80@DB6PR04MB2999.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/23/2017 11:39 AM, Russell King - ARM Linux wrote:
> On Fri, Jun 23, 2017 at 04:56:10PM +0200, Arnd Bergmann wrote:
>> On Tue, Jun 20, 2017 at 7:27 PM, Leo Li <leoyang.li@nxp.com> wrote:
>>> v2: Removed the patches for MAINTAINERS file as they are already picked
>>> up by powerpc tree.
>>>
>>> v3: Added signed tag to the pull request.
>>>
>>> Hi arm-soc maintainers,
>>>
>>> As Scott has left NXP, he agreed to transfer the maintainership of
>>> drivers/soc/fsl to me.  Previously most of the soc drivers were going
>>> through the powerpc tree as they were only used/tested on Power-based
>>> SoCs.  Going forward new changes will be mostly related to arm/arm64
>>> SoCs, and I would prefer them to go through the arm-soc tree.
>>>
>>> This pull request includes updates to the QMAN/BMAN drivers to make
>>> them work on the arm/arm64 architectures in addition to the power
>>> architecture.
>>>
>>> DPAA (Data Path Acceleration Architecture) is a set of hardware
>>> components used on some FSL/NXP QorIQ Networking SoCs, it provides the
>>> infrastructure to support simplified sharing of networking interfaces
>>> and accelerators by multiple CPU cores, and the accelerators
>>> themselves.  The QMan(Queue Manager) and BMan(Buffer Manager) are
>>> infrastructural components within the DPAA framework.  They are used to
>>> manage queues and buffers for various I/O interfaces, hardware
>>> accelerators.
>>>
>>> More information can be found via link:
>>> http://www.nxp.com/products/microcontrollers-and-processors/power-architecture-processors/qoriq-platforms/data-path-acceleration:QORIQ_DPAA
>> Hi Leo,
>>
>> sorry for taking you through yet another revision, but I have two
>> more points here:
>>
>> 1. Please add a tag description whenever you create a signed tag. The
>> description is what ends up in the git history, and if there is none, I have
>> to think of something myself. In this case, the text above seems
>> roughly appropriate, so I first copied it into the commit log, but then
>> noticed the second issue:
>>
>> 2. I know we have discussed the unusual way this driver accesses MMIO
>> registers in the past, using ioremap_wc() to map them and the manually
>> flushing the caches to store the cache contents into the MMIO registers.
>> What I don't know is whether there was any conclusion on this topic whether
>> this is actually allowed by the architecture or at least the chip, based on
>> implementation-specific features that make it work even when the architecture
>> doesn't guarantee it.
>>
>> Can I have an Ack from the architecture maintainers (Russell, Catalin,
>> Will) on the use of these architecture specific interfaces?
>>
>> static inline void dpaa_flush(void *p)
>> {
>> #ifdef CONFIG_PPC
>>         flush_dcache_range((unsigned long)p, (unsigned long)p+64);
>> #elif defined(CONFIG_ARM32)
>>         __cpuc_flush_dcache_area(p, 64);
>> #elif defined(CONFIG_ARM64)
>>         __flush_dcache_area(p, 64);
>> #endif
>> }
>> #define dpaa_invalidate(p) dpaa_flush(p)
>> #define dpaa_zero(p) memset(p, 0, 64)
>> static inline void dpaa_touch_ro(void *p)
>> {
>> #if (L1_CACHE_BYTES == 32)
>>         prefetch(p+32);
>> #endif
>>         prefetch(p);
>> }
>>
>> As described by Leo, the code is already there and is actively used
>> on powerpc, his pull request is merely for enabling the driver on ARM
>> and ARM64.
> Well, as arch maintainer, "code already there" matters not one bit when
> converting it to work on other architectures.
>
> For the record, I'm completely dismaid that there seems to be:
>
> (a) the thought of getting changes into the kernel that use arch-private
>     interfaces without review by architecture maintainers.
>
>     Here, I'm specifically talking about the work that was merged through
>     PowerPC trees adding rather broken ARM support to this driver.
The PowerPC support was added to support PowerPC - this device has
existed on PowerPC parts for many years before we started developing ARM
cores. We have been trying to "catch up" on our upstreaming efforts for
this family of parts and PowerPC was done first primary because there
are more parts available at this point in time.
>
> (b) the lack of Cc to ARM and ARM64 architecture maintainers of the patch
>     set now being asked to be merged through Arnd.
I apologize for the lack of CC - many of us are new to the ARM community
and learning who should be CC'd on requests takes time. The patch set
was originally posted on the ARM list in January of this year and we
have incorporated feedback from many people, including Robin Murphy and
yourself.  I certainly want and value the feedback from the community. 
The reason we were requesting the patches be merged is that the last
submission had no feedback after several rounds review (starting in
January).
>
> (c) the thought that it's acceptable to use architecture private interfaces
>     in driver code that really have no business being there.
>
> (d) the lack of explanation why its necessary to poke about using
>     architecture private interfaces.
>
> Now, from looking at the code already merged in mainline, I think that
> this driver really has no business touching these arch private
> interfaces.
>
> I think, rather than myself and Will/Catalin independently spending time
> trying to understand what's going on with this code, what we need is for
> NXP people to document in detail what they are doing that requires all
> this special treatment and why they need to poking about in stuff that's
> architecture private before this can be merged.
>
> Basically, I want a proper understanding of this code to fully
> understand why it's using arch private interfaces, and what the problem
> is with using the standard interfaces provided for drivers.
The requested pull removed most of the ARCH specific code so I would
recommend looking at the driver with those patches applied.  I will
enumerate here all the places in the final driver that check for
CONFIG_ARM or CONFIG_PPC

1) bman.c : Some register offsets in the device changed when we moved
the IP to ARM, we use CONFIG_ARM||CONFIG_ARM64 to do the defines at
different offsets for each platform.
2) bman_portal.c : On PPC we map the SW portals as
cacheable/noncoherent. This is required for those devices as they will
cause a trap if the memory isn't mapped that way.  When the device was
moved to ARM we removed that limitation.  Since mapping the device as
non-shareable is controversial the code is using ioremap_wc() right
now.  This code will potentially change once there is more discussion on
this but for now we distinguish between the two architectures.
3) dpaa_sys.h: I mentioned the dpaa_flush() in a previous message.  This
can likely be changed but it has performance implications.
4) qman.c: Same register offset buisness as point 1 but for QMan.
5) qman_portal.c:  The same non-sharable difference exists as mentioned
in bullet 2

I'm not aware of any other code that is architecture dependent. The only
architecture private interface is the flush() and I'm willing to look
into how much impact changing it will have if it is a showstopper.
