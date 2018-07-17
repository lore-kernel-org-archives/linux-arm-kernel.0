From: james.morse@arm.com (James Morse)
Date: Tue, 17 Jul 2018 15:20:47 +0100
Subject: [PATCH] arm64: fix kernel panic on serror exception caused by
 user process
In-Reply-To: <CAM5rFu8avWLrUhEsCHBTKv=sM6dE3Sh_0=5M3Eh0WcT9EdmtSg@mail.gmail.com>
References: <1531819881-2931-1-git-send-email-hari.vyas@broadcom.com>
 <1531819881-2931-2-git-send-email-hari.vyas@broadcom.com>
 <20180717100628.s5emikyc6orira2q@lakrids.cambridge.arm.com>
 <CAM5rFu_trZpt20H2GAUq8GYTOuJMSmEknsQaEkPkDwFHPVDPeA@mail.gmail.com>
 <20180717114815.5a3rbcznfzvi2xh6@lakrids.cambridge.arm.com>
 <CAM5rFu8avWLrUhEsCHBTKv=sM6dE3Sh_0=5M3Eh0WcT9EdmtSg@mail.gmail.com>
Message-ID: <6ac1a5b0-6767-bb76-012e-b8270a580ca2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi hari,

On 17/07/18 14:40, Hari Vyas wrote:
> On Tue, Jul 17, 2018 at 5:18 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> ... indeed, and this was a bug, which was addressed by ensuring that
>> an uncontainable SError was always fatal.
>>
> If I check commit message for do_serror(), it says some hooks can be
> added to avoid panic.
> ---
> commit a92d4d1454ab8b43b80b89fa31fcedb8821f8164
> Author: Xie XiuQi <xiexiuqi@huawei.com>
> 
> Future patches may change do_serror() to return if the SError
> Interrupt was notification of a
> corrected error
>  --

This is referring to the v8.2 RAS Extensions, which add architect-ed ESR values
to SError. In this example the CPU would use the ESR_ELx.AET bits to describe
the error as something hardware has corrected. e.g. using ecc. (details in
D10.2.39 of the ARM-ARM and [0])
commit 6bf0dcfd7135 ("arm64: kernel: Survive corrected RAS errors notified by
SError") adds these hooks based on the ESR information.

Without the information in the ESR (and a few other registers), we can't know
what the SError means, it has to be fatal.


Thanks,

James

[0]
https://static.docs.arm.com/ddi0587/a/RAS%20Extension-release%20candidate_march_29.pdf
