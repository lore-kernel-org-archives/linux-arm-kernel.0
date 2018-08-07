From: will.deacon@arm.com (Will Deacon)
Date: Tue, 7 Aug 2018 17:57:14 +0100
Subject: [RFC PATCH 3/3] dynamic_debug: Add support for dynamic register
 trace
In-Reply-To: <37c723a7892b21eb67b8447160d8d602703f321f.1533211509.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1533211508.git.saiprakash.ranjan@codeaurora.org>
 <37c723a7892b21eb67b8447160d8d602703f321f.1533211509.git.saiprakash.ranjan@codeaurora.org>
Message-ID: <20180807165713.GJ21809@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 03, 2018 at 07:58:44PM +0530, Sai Prakash Ranjan wrote:
> Introduce dynamic debug filtering mechanism to register
> tracing as dynamic_rtb() which will reduce a lot of
> overhead otherwise of tracing all the register reads/writes
> in all files.
> 
> Now we can just specify the file name or any wildcard pattern
> as any other dynamic debug facility in bootargs and dynamic rtb
> will just trace them and the output can be seen in pstore.
> 
> TODO: Now we use same 'p' flag but will add a separate flag for register trace
> later.
> 
> Example for tracing all register reads/writes in drivers/soc/qcom/* below:
> 
>   # dyndbg="file drivers/soc/qcom/* +p" in bootargs
>   # reboot -f
>   # mount -t pstore pstore /sys/fs/pstore
>   # cat /sys/fs/pstore/rtb-ramoops-0
>     [LOGK_WRITEL ] ts:1373030419  data:ffff00000d5065a4  <ffff00000867cb44>  qcom_smsm_probe+0x51c/0x668
>     [LOGK_WRITEL ] ts:1373360576  data:ffff00000d506608  <ffff00000867cb44>  qcom_smsm_probe+0x51c/0x668
> 
> Also we add uncached_logk api to readl/writel definitions for arm64
> as of now. This can be extended to arm as well later for tracing.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  arch/arm64/include/asm/io.h   | 93 +++++++++++++++++++++++++++++++++++

Putting all of this in the arch code, which basically duplicates everything,
feels very wrong to me. Perhaps take a look at the ongoing work for
instrumenting the atomics and take some inspiration from there?

Ideally, the architecture just needs to provide the low-level primivites
(which it already does) and the core can generate instruments versions if
required.

Will
