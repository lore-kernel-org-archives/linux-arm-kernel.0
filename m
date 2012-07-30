From: ccross@android.com (Colin Cross)
Date: Mon, 30 Jul 2012 10:33:34 -0700
Subject: [PATCH 03/11] kdb: Implement disable_nmi command
In-Reply-To: <1343649500-18491-3-git-send-email-anton.vorontsov@linaro.org>
References: <20120730115719.GA5742@lizard>
 <1343649500-18491-3-git-send-email-anton.vorontsov@linaro.org>
Message-ID: <CAMbhsRS1cOf1T8k7K6CFmRA7M52AGPZ2TqmEnpZqDGYnbyetbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 4:58 AM, Anton Vorontsov
<anton.vorontsov@linaro.org> wrote:
> This command disables NMI-entry. If NMI source was previously shared with
> a serial console ("debug port"), this effectively releases the port from
> KDB exclusive use, and makes the console available for normal use.
>
> Of course, NMI can be reenabled, enable_nmi modparam is used for that:
>
>         echo 1 > /sys/module/kdb/parameters/enable_nmi

This is very different behavior from the FIQ debugger "console"
command you are trying to replace.  In the FIQ debugger, everything
goes through the FIQ/NMI, even when in console mode.  That means that
the user can always get back to FIQ debugger/KDB mode using a special
sequence (we use a break character).  With your implementation, if you
switch from KDB to console to see if the console is working, and find
that it is not working, you can never get back into KDB.
