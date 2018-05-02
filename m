From: agraf@suse.de (Alexander Graf)
Date: Wed, 2 May 2018 15:16:16 +0200
Subject: [RFC PATCH] driver core: make deferring probe forever optional
In-Reply-To: <20180501213114.20183-1-robh@kernel.org>
References: <20180501213114.20183-1-robh@kernel.org>
Message-ID: <e7755330-bb6f-ad3a-fb82-7fc85a4cfac3@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/2018 11:31 PM, Rob Herring wrote:
> Deferred probe will currently wait forever on dependent devices to probe,
> but sometimes a driver will never exist. It's also not always critical for
> a driver to exist. Platforms can rely on default configuration from the
> bootloader or reset defaults for things such as pinctrl and power domains.
> This is often the case with initial platform support until various drivers
> get enabled. There's at least 2 scenarios where deferred probe can render
> a platform broken. Both involve using a DT which has more devices and
> dependencies than the kernel supports. The 1st case is a driver may be
> disabled in the kernel config. The 2nd case is the kernel version may
> simply not have the dependent driver. This can happen if using a newer DT
> (provided by firmware perhaps) with a stable kernel version.
>
> Unfortunately, this change breaks with modules as we have no way of
> knowing when modules are done loading. One possibility is to make this
> opt in or out based on compatible strings rather than at a subsystem level.
> Ideally this information could be extracted automatically somehow. OTOH,
> maybe the lists are pretty small. There's only a handful of subsystems
> that can be optional, and then only so many drivers in those that can be
> modules (at least for pinctrl, many drivers are built-in only).
>
> Cc: Alexander Graf <agraf@suse.de>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> This patch came out of a discussion on the ARM boot-architecture
> list[1] about DT forwards and backwards compatibility issues. There are
> issues with newer DTs breaking on older, stable kernels. Some of these
> are difficult to solve, but cases of optional devices not having
> kernel support should be solvable.

I think this is a reasonable approach. Maybe this should be a CONFIG 
option that disallows pinctrl drivers (and power domain later) to be =m? 
Then by default we could force those drivers to be compiled in, but if 
you really wanted to do kernel modules for pinctrl/pd you'd consciously 
potentially lose forward compatibility.


Alex
