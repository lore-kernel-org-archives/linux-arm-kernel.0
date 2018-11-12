From: will.deacon@arm.com (Will Deacon)
Date: Mon, 12 Nov 2018 18:36:23 +0000
Subject: [PATCH 2/2] arm64: defconfig: enable BPF related configs
In-Reply-To: <20181111181048.10933-2-pbrobinson@gmail.com>
References: <20181111181048.10933-1-pbrobinson@gmail.com>
 <20181111181048.10933-2-pbrobinson@gmail.com>
Message-ID: <20181112183623.GA2265@brain-police>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter, [+Jann and Ard]

On Sun, Nov 11, 2018 at 06:10:48PM +0000, Peter Robinson wrote:
> The BPF components are getting more widely used by various components
> so we should enable them in the ARMv7 multi config to ensure they
> get wider testing and don't regress.

^^^ Looks like it needs updating for arm64?

> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index c9a57d11330b..8748f6cf9fcd 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -19,6 +19,7 @@ CONFIG_BLK_CGROUP=y
>  CONFIG_CGROUP_PIDS=y
>  CONFIG_CGROUP_HUGETLB=y
>  CONFIG_CPUSETS=y
> +CONFIG_CGROUP_BPF=y
>  CONFIG_CGROUP_DEVICE=y
>  CONFIG_CGROUP_CPUACCT=y
>  CONFIG_CGROUP_PERF=y
> @@ -157,7 +158,10 @@ CONFIG_VLAN_8021Q_MVRP=y
>  CONFIG_QRTR=m
>  CONFIG_QRTR_SMD=m
>  CONFIG_QRTR_TUN=m
> +CONFIG_BPF_SYSCALL=y
>  CONFIG_BPF_JIT=y
> +CONFIG_BPF_JIT_ALWAYS_ON=y

Have you considered the security impact of these two options at all? Whilst
there appears to be a sysctl to disable unprivileged BPF usage, it's a
one-way switch so it defaults to "allow unprivileged access" so we're
opening up a pretty big attack surface by default with this change. My
concerns are broadly:

  1. BPF has a track record of serious security problems. This isn't
     intended as a criticism of the developers, it's more that the nature of
     the beast means it's a bit of a sitting duck. It's also constantly growing
     new functionality which would then likely be enabled by default under
     these options, so I fully expect things to continue as they are until
     the feature set has started to stabilise.

  2. Whilst forcing the JIT to be "always on" removes the interpreter from the
     equation (and it's the interpreter which was heavily targetted by
     spectre-v2), it also has the nasty consequent of effectively allowing the
     modules area to be sprayed with executable code.

Now, this is only defconfig we're talking about here, but the impression I
get from your patch is that your motivation is purely (ARMv7?) regression
testing and I would prefer us at least to consider whether there are other
implications from enabling this stuff by default on arm64.

Have other architectures already made this leap?

Thanks,

Will

> +CONFIG_BPF_STREAM_PARSER=y
>  CONFIG_BT=m
>  CONFIG_BT_HIDP=m
>  # CONFIG_BT_HS is not set
> -- 
> 2.19.1
> 
