From: robh@kernel.org (Rob Herring)
Date: Fri, 20 Feb 2015 16:12:41 -0600
Subject: Announce: rmk's nightly builder gets ARM64 support
In-Reply-To: <20150220175931.GL8656@n2100.arm.linux.org.uk>
References: <20150219171220.GA8656@n2100.arm.linux.org.uk>
 <20150219183444.GB8656@n2100.arm.linux.org.uk>
 <20150220092003.GB31692@arm.com>
 <CAKv+Gu_5fOinMVYbk99unmEDSqCF3Z7QdXiQTw0VrrWW16Oc6w@mail.gmail.com>
 <20150220094035.GE8656@n2100.arm.linux.org.uk>
 <20150220102009.GF8656@n2100.arm.linux.org.uk>
 <CAOMZO5Aqx_SQ1oaML=hiVzzJMJ2bNTAsjk-dWFLkETaV4_JO+A@mail.gmail.com>
 <20150220133806.GG8656@n2100.arm.linux.org.uk>
 <CAOMZO5BgrWGciKt0pjpbtX4wP0CgWWN39BcSjnSD89MxKEpBCg@mail.gmail.com>
 <20150220140440.GF31692@arm.com>
 <20150220175931.GL8656@n2100.arm.linux.org.uk>
Message-ID: <CAL_JsqK_aRDyHjhbn9L6q_-OqYH_o4cLNVkDaT+xSJ42BLdauQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 11:59 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Feb 20, 2015 at 02:04:40PM +0000, Will Deacon wrote:
>> On Fri, Feb 20, 2015 at 01:49:22PM +0000, Fabio Estevam wrote:
>> > On Fri, Feb 20, 2015 at 11:38 AM, Russell King - ARM Linux
>> > <linux@arm.linux.org.uk> wrote:
>> >
>> > > From what I can see, this doesn't _build_ a compiler.  It grabs
>> > > gcc-linaro-aarch64-linux-gnu-4.9-2014.08_linux.tar.xz from
>> > > http://releases.linaro.org/14.08/components/toolchain/binaries
>> > > and installs that - which contains a load of binaries.
>> >
>> > That's correct. It uses the pre-built binaries from Linaro.
>>
>> For sources, you can usually just pick up the latest GCC release. For
>> example, 4.9.2 worked for me:
>>
>>   ftp://ftp.mirrorservice.org/sites/sourceware.org/pub/gcc/releases/gcc-4.9.2/gcc-4.9.2.tar.bz2
>>
>> I can't recommend using trunk at the moment (i.e. GCC 5), as we hit some
>> issues with the PSCI calling code that I plan to post fixes for at -rc1.
>
> Thanks, that version of gcc appears to work correctly with the kernel.
> I've updated the builder with that.
>
> There's a number of worrying warnings for ldp/stp instructions though.
> Is that a binutils issue, or a KVM issue?
>
> I've sent Greg a fix for the drivers/base/component.c warning.
>
> There's a number of warnings in drivers/pci/host/pci-xgene.c which
> look like they need resolving - returning NULL from a function which
> returns an 'int' has never been valid - has this commit (which seems
> to have introduced the problem) actually been tested?
>
> Maybe xgene_pcie_map_bus() is supposed to return a void * ?

There's a fix for this which has not yet landed[1].

Rob

[1] https://patchwork.ozlabs.org/patch/440759/

>
> commit 350f8be5bb402a1d6804adeba0031926ad246bf1
> Author: Rob Herring <robh@kernel.org>
> Date:   Fri Jan 9 20:34:49 2015 -0600
>
>     PCI: xgene: Convert to use generic config accessors
>
>     Convert the xgene host PCI driver to use the generic config access
>     functions.
>
>     Signed-off-by: Rob Herring <robh@kernel.org>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     CC: Tanmay Inamdar <tinamdar@apm.com>
>     CC: linux-arm-kernel at lists.infradead.org
>
>
> --
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.
