From: Dave.Martin@arm.com (Dave P Martin)
Date: Tue, 5 May 2015 12:11:56 +0100
Subject: [PATCH] serial/amba-pl011: fix minor bugs for pio mode
In-Reply-To: <1430794825-14367-1-git-send-email-leo.yan@linaro.org>
References: <1430794825-14367-1-git-send-email-leo.yan@linaro.org>
Message-ID: <20150505111155.GA16868@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, May 05, 2015 at 04:00:25AM +0100, Leo Yan wrote:
> When use pio mode, there have two issues can be observed:
> 
> - In the commit 2240197 "serial/amba-pl011: Leave the TX IRQ alone when
>   the UART is not open", it will skip clearing the TX IRQ across
>   pl011_shutdown() and pl011_startup(); So at the next time after the
>   uart port has been opened, there have chance for the function
>   pl011_tx_chars() will not be executed if the TX IRQ will not be
>   triggered; finally the console cannot output anymore.
> 
>   This is caused by the uart FIFO still keep data rather than
>   the threshold. So revert this patch to make sure every time open the
>   uart port, it will force to call function pl011_tx_chars().
> 
> - Sometimes will output the duplicate chars. Function pl011_tx_char()
>   will firstly send char and check if FIFO is full, and if the FIFO is
>   full it will return false; Caller function will consider the char
>   has _NOT_ been send out and resend it again, finally will send the
>   duplicate chars. So change to check FIFO is full or not, if full then
>   return false, otherwise send out char and return true.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

[...]

Thanks for the fixes, but I already posted patches that probably fix the
issues you are observing, And Greg took them into his tty-testing branch.

Can you give them a try instead of your patches?

Dave Martin (2):
      Revert "serial/amba-pl011: Leave the TX IRQ alone when the UART is not open"
      serial/amba-pl011: Refactor and simplify TX FIFO handling

from

git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing


It would be good to have some feedback on them.

Cheers
---Dave
