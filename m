From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 24 Oct 2014 11:03:31 -0700
Subject: [PATCH] ARM: OMAP4+: PM: Program CPU logic power state
In-Reply-To: <1413923076-26063-1-git-send-email-nm@ti.com> (Nishanth Menon's
 message of "Tue, 21 Oct 2014 15:24:36 -0500")
References: <1413923076-26063-1-git-send-email-nm@ti.com>
Message-ID: <7h61f98hvw.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nishanth Menon <nm@ti.com> writes:

> CPU logic power state is never programmed in either the initialization
> or the suspend/resume logic, instead, we depend on mpuss to program this
> properly. However, this leaves CPU logic power state indeterminate and
> most probably in reset configuration (If bootloader or other similar
> software have'nt monkeyed with the register). This can make powerstate=
> RET be either programmed for CSWR (logic=ret) or OSWR(logic = OFF) and
> in OSWR, there can be context loss when the code does not expect it.
>
> To prevent all these confusions, just support clearly ON, INA, CSWR,
> OFF which is the intent of the existing code by explicitly programming
> logic state.
>
> NOTE: since this is a hot path (using in cpuidle), the exit path just
> programs powerstate (logic state is immaterial when powerstate is ON).
>
> Without doing this, we end up with lockups when CPUs enter OSWR and
> multiple blocks loose context, when we expect them to hit CSWR.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Kevin Hilman <khilman@linaro.org>
