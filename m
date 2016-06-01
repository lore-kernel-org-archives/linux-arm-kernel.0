From: riku.voipio@linaro.org (Riku Voipio)
Date: Wed, 1 Jun 2016 10:39:09 +0300
Subject: [PATCH] arm64: defconfig: add options for virtualization and
 containers
In-Reply-To: <20160531142321.GB11321@e104818-lin.cambridge.arm.com>
References: <1464345747-11729-1-git-send-email-riku.voipio@linaro.org>
 <20160531135740.GL24936@arm.com>
 <20160531142321.GB11321@e104818-lin.cambridge.arm.com>
Message-ID: <CAAqcGHmESq=DB9MTGfNuLPqCrGc=00N+JQMtf1BHvCY_MW4Vqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 May 2016 at 17:23, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Tue, May 31, 2016 at 02:57:41PM +0100, Will Deacon wrote:
>> On Fri, May 27, 2016 at 01:42:27PM +0300, Riku Voipio wrote:
>> > Enable options commonly needed by popular virtualization
>> > and container applications. Use modules when possible to
>> > avoid too much overhead for users not interested.
>> >
>> > - add namespace and cgroup options needed
>> > - add seccomp - optional, but enhances Qemu etc
>> > - bridge, nat, veth, macvtap and multicast for routing
>> >   guests and containers
>> > - btfrs and overlayfs modules for container COW backends
>> > - while near it, make fuse a module instead of built-in.
>> >
>> > Generated with make saveconfig and dropping unrelated spurious
>> > change hunks while commiting. bloat-o-meter old-vmlinux vmlinux:
>> >
>> > add/remove: 899/388 grow/shrink: 744/216 up/down: 183556/-94881 (88675)
>> > ...
>> > Total: Before=10515333, After=10604008, chg 0.000000%
>> >
>> > Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
>> > ---
>> >  arch/arm64/configs/defconfig | 53 +++++++++++++++++++++++++++++++++++++++-----
>> >  1 file changed, 47 insertions(+), 6 deletions(-)
>>
>> I'm fine with adding stuff to defconfig if it's useful to people (and it
>> looks like this is), but it's probably about time we figured out what to
>> do about '=y' vs '=m'. Until recently (i.e. this merge window), the arm64
>> defconfig didn't build any modules. Obviously this only scales so far,
>> since the Image tends to get rather huge, but it would be good to try and
>> establish a rule-of-thumb as to whether we treat something as a module
>> or a built-in. We could even consider retrospectively applying the rule
>> if its straightforward enough.
>>
>> One easy way to do it would be: if you need the option to boot, then
>> it's a built-in, but that brings up questions around "boot a full android
>> system" vs "boot to a point where you could load an initrd".
>
> For the time being, I would say defconfig should cover "boot to a login
> prompt" where this may imply NFS + network driver built in for the
> supported SoCs, couple of commonly used filesystems (ext4, btrfs). The
> rest can be enabled as modules.

Sounds like a good rule of thumb. This is roughly what I've followed
in my patch. Some options can only be enabled as built-in, such as
cgroup/namespace/seccomp options. I think for these, setting them as
=y makes sense since major distributions do it also. Distributions
make everything possible as modules, so having something built-in is
pretty strong vote for the feature to be built-in the kernel.

> As the image continues to grow over years, we will have to revisit this
> and possibly separate the mobile from the server SoC defconfig. For the
> former, we can probably keep the same "boot to a login prompt" approach.
> For the latter, especially if you install it under a distro (e.g. you do
> make deb-pkg or rpm-pkg), we can aim for "boot to initramfs". That said,
> I'd like to see most of the SoC drivers stuff built as modules (whatever
> is not essential for booting to initramfs and comes in at
> device_initcall level).
>
> --
> Catalin
