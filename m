From: olof@lixom.net (Olof Johansson)
Date: Wed, 27 Nov 2013 11:27:34 -0800
Subject: [PATCH] Documentation: devicetree: arm: add lpae property to
 cpus/cpu bindings
In-Reply-To: <20131127094911.GE5402@e106331-lin.cambridge.arm.com>
References: <1385517172-803-1-git-send-email-olof@lixom.net>
 <20131127094911.GE5402@e106331-lin.cambridge.arm.com>
Message-ID: <CAOesGMh9aQEtqha3gt80q4RmLjXtFTc+Xt39M0m+geTk_betzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 27, 2013 at 1:49 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Olof,
>
> On Wed, Nov 27, 2013 at 01:52:52AM +0000, Olof Johansson wrote:
>> While the LPAE capability is determined by the kernel today, it is still
>> useful to be able to specify the feature in the device tree. There is
>> precedence from other architectures for this.
>>
>> Signed-off-by: Olof Johansson <olof@lixom.net>
>> ---
>>
>> My personal motive for this is to be able to tell which boards are
>> work even trying to boot an LPAE kernel on, since we don't disable the
>> platforms that are based on A8/A9 when LPAE is turned on. I'll add dtsi
>> patches for A7/A15-based platforms once the binding is settled.
>
> It would be nice to have this description of why you want to add this in
> the commit message proper.

Sure.

> I don't see much point in this. If we're going to add this to the DTSIs
> for all platforms that have CPUs with LPAE support, why not just check
> if a given DT contains one of those CPUs to find out if it has LPAE
> support?

Because it's awkward to have to do a table with each cpu compatible
value that is known to support LPAE everywhere it's needed.

Alternatively we could have a common compatible field for shared
features, but that also won't scale (we don't have a compatible field
today to indicate architecture version, and this would be an
incremental part on top of that).

> The information this flag describes is at best redundant, but could also
> be missing or present erroneously.

That is true for many other device tree properties too.

> It's also of no use to any OS actually running on the hardware, as it's
> easier for an OS to check ID_MMFR0[3:0] than to parse a DTB. Likewise
> for bootloaders.

Compare this to the PowerPC processor binding from IEEE1275, and
you'll see that there are some similarities, for example when it comes
to properties describing support of certain instructions (which could
be probed by inserting illegal instruction handlers and attempting to
execute them). They also have properties for cpu-version and a few
other similar things that can be read from registers.

>> I don't think it's worth trying to add those dependencies in Kconfig,
>> by the way -- it'd be pretty verbose and churny.
>
> I think if we want an early warning that a particular platform is not
> going to support LPAE, this would be a better place to put it.

It's problematic because you really need to annotate every platform
that _doesn't_ support LPAE to get something that works. Otherwise, if
you have one platform that selects something like CONFIG_HAVE_LPAE,
then just enabling that platform together with the rest of them means
you can turn it on, even if the older platforms can't boot any more.

So, you'd need every non-A15/A7 platform select a CONFIG_NO_LPAE of
whatnot, which doesn't scale.

Alternatively we'll need to add a config option per cpu, and have
CONFIG_ARM_LPAE depend on !CORTEX_A8 && !CORTEX_A9 && !<qualcomm v7
cpus> && !<marvell v7 cpus>. That's also ugly.

> It's a shame we don't have a standard header in the Linux Image. If we
> did, we could add a "uses LPAE" flag to the Linux Image that bootloaders
> could check and refuse to run the Image or print a warning if the HW had
> no LPAE support.

Yep, unfortunate.


-Olof
