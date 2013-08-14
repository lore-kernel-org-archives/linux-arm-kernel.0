From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 14 Aug 2013 14:05:58 -0400 (EDT)
Subject: [PATCHv3 0/5] arm64: initial CPU hotplug support
In-Reply-To: <1376497228-20543-1-git-send-email-mark.rutland@arm.com>
References: <1376497228-20543-1-git-send-email-mark.rutland@arm.com>
Message-ID: <alpine.LFD.2.03.1308141354500.14472@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Aug 2013, Mark Rutland wrote:

> The following patches add basic HOTPLUG_CPU support to arm64, which
> combined with appropriate firmware (e.g. [1]) can be used to power CPUs
> up and down dynamically.
> 
> I've tested this series with the bootwrapper PSCI implementation I've
> placed on linux-arm.org [1] and a modified foundation model dts with a
> psci node and each CPU's enable-method set to "psci", using a shell
> while repeatedly cycling all cpus off and on:
> 
> for C in $(seq 0 3); do
> 	./cyclichotplug.sh $C >/dev/null 2>&1 &

Maybe you should not redirect stdout/stderr to /dev/null.  Otherwise, if 
your test encounters any problem you simply won't notice.

> done
> 
> ---->8----
> #!/bin/sh
> # cyclichotplug.sh
> 
> CPU=$1;
> 
> if [ -z "$CPU" ]; then
> 	printf "Usage: $0 <cpu id>\n";
> 	exit 1;
> fi
> 
> ONLINEFILE=/sys/devices/system/cpu/cpu$CPU/online;
> 
> while true; do
> 	echo 0 > $ONLINEFILE;
> 	echo 1 > $ONLINEFILE;
> done

I'd suggest you introduce some randomness within that loop to avoid 
lockstep behaviors.  With bash you may use $RANDOM and use:

	usleep $RANDOM

before each echo invocation.

Or, with sufficient recent coreutils versions, the sleep command may 
accept fractional values:

	sleep 0.0$RANDOM


Nicolas
