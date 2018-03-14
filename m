From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 14 Mar 2018 18:24:48 +0000
Subject: [Query] ARM64 kaslr support - randomness, seeding and kdump
In-Reply-To: <20180314021050.GK25863@linaro.org>
References: <CACi5LpMhHt4bjEueOzHZTGpzuR2zoQqXcReL-khoSNLG6=FVmg@mail.gmail.com>
 <CAKv+Gu8qd=rpJkG_GoVO=kkmc4qx_zZD8c_wwE16gr=8wSShSw@mail.gmail.com>
 <20180313102158.GI25863@linaro.org>
 <20180313104715.prurmrizho4ddc4l@lakrids.cambridge.arm.com>
 <20180313110747.GJ25863@linaro.org>
 <20180313112016.ocx4qqhji3zfwjhs@lakrids.cambridge.arm.com>
 <CACi5LpN4DTYFVSVqru2j0y=CKr2ztrJ1gCW32sJBU=oUV2fcWw@mail.gmail.com>
 <20180314021050.GK25863@linaro.org>
Message-ID: <20180314182448.bnvjtgyzipsuxcbe@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2018 at 11:10:53AM +0900, AKASHI Takahiro wrote:
> If kaslr-seed has a critical value in terms of security, is kexec-tools
> a right place? It is exposed to user space albeit for a short time of period.

The kernel zeroes the seed in the DT at boot time, so the current seed
isn't visible to userspace.

If kexec-tools generates a seed, and inserts it into the DTB that it
loads, this is only visible to kexec tools or other applications which
can inspect its memory, so I don't think this is much of a concern.
Anything with such privilege can presumably kexec() to arbitrary code
anyhow.

The next kernel will then zero its seed in the DT at boot time, so
similarly this won't be visible to userspace on the new kernel.

FWIW, having kexec tools generate a seed for the kexec_load() case makes
sense to me.

Thanks,
Mark.
