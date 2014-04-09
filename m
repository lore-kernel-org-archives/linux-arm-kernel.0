From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Wed, 09 Apr 2014 11:29:38 +0100
Subject: [PATCH 2/2] ARM: mm: make text and rodata read-only
In-Reply-To: <20140408194815.GA6188@debian>
References: <1396577719-14786-1-git-send-email-keescook@chromium.org>
 <1396577719-14786-3-git-send-email-keescook@chromium.org>
 <20140404195818.GA21028@debian>
 <CAGXu5jKPX2igsb2rQzdCZQZ8X3h4YZihCV9D+cDW3F+qii8H2A@mail.gmail.com>
 <1396960898.3567.55.camel@linaro1.home>
 <CAGXu5jJq24k4uQbBJmihJ4RScJ40o41oKFtm13hBO_YZOvHpkA@mail.gmail.com>
 <1396973561.14809.26.camel@linaro1.home>
 <CAGXu5jJewy0Xy-qUEF2K6bAcEC8ZdKy0Ad2nLPjGRsq20fSQXQ@mail.gmail.com>
 <20140408194815.GA6188@debian>
Message-ID: <1397039378.3537.32.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-04-08 at 21:48 +0200, Rabin Vincent wrote:
[...]
> For any other CPU to pull in the writable entry it would have to get a
> TLB miss inside the loop in multi_cpu_stop(), after the state transition
> to MULTI_STOP_RUN and before the state transition to MULTI_STOP_EXIT.
> This is unlikely, but theoretically possible, for example if
> multi_cpu_stop() straddles sections.

With speculative execution it is also possible for the CPU to fill the
TLB with entries for a memory address that the program would never
actually access. Basically, whatever is in the MMU registers and page
tables at any given time, the CPU can speculatively use that address
translation and read that memory. And if it's marked cacheable, pull it
into the cache. Oh, and if there is a dirty cacheline in another
CPU/clusters cache, move that dirty entry over into it's own cache (I
believe).

-- 
Tixy
