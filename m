From: will.deacon@arm.com (Will Deacon)
Date: Tue, 31 May 2016 14:57:41 +0100
Subject: [PATCH] arm64: defconfig: add options for virtualization and
 containers
In-Reply-To: <1464345747-11729-1-git-send-email-riku.voipio@linaro.org>
References: <1464345747-11729-1-git-send-email-riku.voipio@linaro.org>
Message-ID: <20160531135740.GL24936@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 27, 2016 at 01:42:27PM +0300, Riku Voipio wrote:
> Enable options commonly needed by popular virtualization
> and container applications. Use modules when possible to
> avoid too much overhead for users not interested.
> 
> - add namespace and cgroup options needed
> - add seccomp - optional, but enhances Qemu etc
> - bridge, nat, veth, macvtap and multicast for routing
>   guests and containers
> - btfrs and overlayfs modules for container COW backends
> - while near it, make fuse a module instead of built-in.
> 
> Generated with make saveconfig and dropping unrelated spurious
> change hunks while commiting. bloat-o-meter old-vmlinux vmlinux:
> 
> add/remove: 899/388 grow/shrink: 744/216 up/down: 183556/-94881 (88675)
> ...
> Total: Before=10515333, After=10604008, chg 0.000000%
> 
> Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 53 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 47 insertions(+), 6 deletions(-)

I'm fine with adding stuff to defconfig if it's useful to people (and it
looks like this is), but it's probably about time we figured out what to
do about '=y' vs '=m'. Until recently (i.e. this merge window), the arm64
defconfig didn't build any modules. Obviously this only scales so far,
since the Image tends to get rather huge, but it would be good to try and
establish a rule-of-thumb as to whether we treat something as a module
or a built-in. We could even consider retrospectively applying the rule
if its straightforward enough.

One easy way to do it would be: if you need the option to boot, then
it's a built-in, but that brings up questions around "boot a full android
system" vs "boot to a point where you could load an initrd".

Any ideas? Am I mad trying to put method into madness?

Will
