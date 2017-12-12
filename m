From: afzal.mohd.ma@gmail.com (afzal mohammed)
Date: Tue, 12 Dec 2017 16:33:15 +0530
Subject: [PATCH 1/6] ARM: stm32: prepare stm32 family to welcome armv7
 architecture
In-Reply-To: <CAK8P3a2rrpFuwET8r1H0YWVABbCZr5c2ySrKCgA4mfoZPfWp6Q@mail.gmail.com>
References: <1512742277-28205-1-git-send-email-ludovic.Barre@st.com>
 <1512742277-28205-2-git-send-email-ludovic.Barre@st.com>
 <CACRpkdaKZk5N9F=_nYSzKWyXgW4xQ9Ltft7-UNM+a-nOpqq2xg@mail.gmail.com>
 <CAK8P3a2rrpFuwET8r1H0YWVABbCZr5c2ySrKCgA4mfoZPfWp6Q@mail.gmail.com>
Message-ID: <20171212110315.GA4118@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 11, 2017 at 02:40:43PM +0100, Arnd Bergmann wrote:
> On Mon, Dec 11, 2017 at 11:25 AM, Linus Walleij

> >> This patch prepares the STM32 machine for the integration of Cortex-A
> >> based microprocessor (MPU), on top of the existing Cortex-M
> >> microcontroller family (MCU). Since both MCUs and MPUs are sharing
> >> common hardware blocks we can keep using ARCH_STM32 flag for most of
> >> them. If a hardware block is specific to one family we can use either
> >> ARCH_STM32_MCU or ARCH_STM32_MPU flag.

> To what degree do we need to treat them as separate families
> at all then? I wonder if the MCU/MPU distinction is always that
> clear along the Cortex-M/Cortex-A separation,

> What
> exactly would we miss if we do away with the ARCH_STM32_MCU
> symbol here?

Based on this patch series, the only difference seems to be w.r.t ARM
components, not peripherals outside ARM subystem. Vybrid VF610 is a
similar case, though not identical (it can have both instead of
either), deals w/o extra symbols,

8064887e02fd6 (ARM: vf610: enable Cortex-M4 configuration on Vybrid SoC)

> especially if
> we ever get to a chip that has both types of cores.

Your wish fulfilled, Vybrid VF610 has both A5 & M4F and mainline Linux
boots on both (simultaneously as well), and the second Linux support,
i.e. on M4 went thr' your keyboard, see above commit :)

There are quite a few others as well, TI's AM335x (A8 + M3), AM437x
(A9 + M3), AM57x (A15 + M4), but of these Cortex M's, the one in AM57x
only can be Linux'able. On others they are meant for PM with limited
resources.

> > So yesterdays application processors are todays MCU processors.
> >
> > I said this on a lecture for control systems a while back and
> > stated it as a reason I think RTOSes are not really seeing a bright
> > future compared to Linux.

> I think there is still lots of room for smaller RTOS in the long run,

Me being an electrical engineer & worked to some extent in motor
control on RTOS/no OS (the value of my opinion is questionable
though), the thought of handling the same in Linux (even RT) sends
shivers down my spine. Here, case being considered is the type of
motor (like permanent magnet ones) where each phase of the motor has
to be properly excited during every PWM period (say every 100us,
depending on the feedback, algorithm, other synchronization) w/o which
the motor that has been told to run might try to fly. This is
different from stepper motor where if control misbehaves/stops nothing
harmful normally happens.

But my opinion is a kind of knee-jerk reaction and based on prevalent
atitude in that field, hmm.., probably i should attempt it first.

Regards
afzal
