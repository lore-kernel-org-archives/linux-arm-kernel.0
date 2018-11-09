From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 9 Nov 2018 17:23:45 +0100
Subject: [PATCH 16/27] arm64: compat: Add vDSO
In-Reply-To: <20181109123730.8743-17-vincenzo.frascino@arm.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
 <20181109123730.8743-17-vincenzo.frascino@arm.com>
Message-ID: <CAK8P3a3SHU7S0Ro-N2c-boOF=6W6WZLS7kBS2UXAUyV0VtaTOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 9, 2018 at 1:38 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:

> +
> +static __always_inline notrace int gettimeofday_fallback(struct timeval *_tv,
> +                                                        struct timezone *_tz)

Corresponding to what I said about the native syscalls, this should
eventually use 'old_timeval32' here.

> +static __always_inline notrace long clock_gettime_fallback(clockid_t _clkid,
> +                                                          struct timespec *_ts)

and 'old_timespec32' here.

We could do those changes as a follow-up, but since you change that code
already, we could just as well do it now.

Then there is the question about the replacement. I don't see a need for
64-bit versions of time, gettimeofday or clock_getres, but we definitely want
a new clock_gettime. This probably has to wait until we have assigned a
syscall number (for the fallback implementation), just mentioning it now
so we keep it in mind.

      Arnd
