From: kim.phillips@arm.com (Kim Phillips)
Date: Wed, 23 Aug 2017 11:05:28 -0500
Subject: [PATCH] doc: coresight: correct usage for '/dev/cpu_dma_latency'
In-Reply-To: <1503472998-9009-1-git-send-email-leo.yan@linaro.org>
References: <1503472998-9009-1-git-send-email-leo.yan@linaro.org>
Message-ID: <20170823110528.ba272128cde46f40c71241cc@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Aug 2017 15:23:18 +0800
Leo Yan <leo.yan@linaro.org> wrote:

> Cc: Kim Phillips <kim.phillips@arm.com>
> Reported-by: Kim Phillips <kim.phillips@arm.com>

Thanks; typically only the latter is needed.

>  Set latency request to /dev/cpu_dma_latency to disable all CPUs specific idle
> -states (if latency = 0uS then disable all idle states):
> -# echo "what_ever_latency_you_need_in_uS" > /dev/cpu_dma_latency
> +states (if latency = 0uS then CPU Idle governor selects idle state0, so this
> +means 'WFI' is still enabled but other deeper states have be disabled, this
> +can avoid power off CPUs):
> +# exec 3<> /dev/cpu_dma_latency; echo "what_ever_latency_you_need_in_uS" >&3

not a fan of the "what_ever_latency_you_need_in_uS" (including and
especially the quotes which can create ambiguity in the user's mind):
just put a cut-n-pasteable example, clarifying the typically-default
value you chose, and its unit, in the text.

More to the point, how did you test this?  Are you sure that that the
value being echoed isn't being interpreted as a binary number?

kernel/power/qos.c:pm_qos_power_read() looks to be looking for a 32-bit
binary integer, but I'm not sure if that's where it gets read.

Certainly, this 2013 article uses a C example to write a binary integer:

https://access.redhat.com/articles/65410

Please double-check, thanks,

Kim
