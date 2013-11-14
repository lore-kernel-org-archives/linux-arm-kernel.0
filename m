From: fweisbec@gmail.com (Frederic Weisbecker)
Date: Thu, 14 Nov 2013 12:50:05 +0100
Subject: a bug on NO_HZ_FULL_ALL
In-Reply-To: <CANHzE=0yshUSnxRRhQ_hBjo8ze4pSzuWQq+SAWdosq+wdP8hFg@mail.gmail.com>
References: <CANHzE=2EOJmjFqLUDSfxTvgQhrUogOxH8Qux9hBFTGf8HiWWEw@mail.gmail.com>
 <52843855.5060509@linaro.org> <52847FBE.9070501@linaro.org>
 <CAKfTPtD7fo08mjQoLXMMDpyxQuyoCZLS33qBnnUcQEmzYai2VQ@mail.gmail.com>
 <52848547.9080604@linaro.org>
 <CANHzE=0yshUSnxRRhQ_hBjo8ze4pSzuWQq+SAWdosq+wdP8hFg@mail.gmail.com>
Message-ID: <20131114115004.GB16501@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 05:54:10PM +0800, Shaojie Sun wrote:
> No, I think it is a bug.
> 
> Because I tested the option with NO_HZ_FULL and without
> NO_HZ_FULL_ALL. It had only little interruptes on CPU0 twd.
> With same code, I added NO_HZ_FULL_ALL option. It had too many
> interruptes on CPU0 twd.

If you select:

   NO_HZ_FULL=y
   NO_HZ_FULL_ALL=n

then you need to pass a nohz_full= cpu range in the boot parameter, otherwise it's
simply going to behave like NO_HZ_FULL=n

OTOH, if you select NO_HZ_FULL_ALL=y, the "nohz_full=" parameter is not needed and
all CPUs will be full dynticks except CPU 0 where you should see more tick than usual
because it's handling the timekeeping for every other CPUs. Don't forget to select
CONFIG_NO_HZ_FULL_SYSIDLE=y or CPU 0 will never shutdown its tick even if the entire
system is idle.
