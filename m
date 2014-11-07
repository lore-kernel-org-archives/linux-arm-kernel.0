From: marex@denx.de (Marek Vasut)
Date: Fri, 7 Nov 2014 09:03:11 +0100
Subject: [PATCH v4 2/4] serial: mxs-auart: use mctrl_gpio helpers for
 handling modem signals
In-Reply-To: <CAMiH66FKJm8hcgtR=-ZzzpCq+PQ8xkixbUnMzRPVd_cM_6VM1w@mail.gmail.com>
References: <1412960007-28159-1-git-send-email-j.uzycki@elproma.com.pl>
 <545B57D7.4070609@elproma.com.pl>
 <CAMiH66FKJm8hcgtR=-ZzzpCq+PQ8xkixbUnMzRPVd_cM_6VM1w@mail.gmail.com>
Message-ID: <201411070903.11645.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, November 07, 2014 at 02:34:31 AM, Huang Shijie wrote:
> why change them to gpio?  If we change them to gpio.  Could the DMA still
> works fine?
> did you test the DMA with this patch?
> 
> Add Marek for this patch too.

I didn't look too deep into the patch, so here's just my experience:

1) The AUART block signals and GPIO block signals are not sychronised using the 
   same clock. Therefore, the latency between toggling of the AUART lines and
   the GPIO-driven pins will not be deterministic and will vary. There might be
   a way to approximate that, but that's definitelly not a reliable solution.

   This is very bad for example if you drive RS485 DIR line with the RTS pin as
   a GPIO ; the RTS pin will toggle at non-deterministic time compared to the
   end of UART transmission. This will trigger bit-loss on the RS485 line and
   you just don't want that.

2) Speaking of RS485, there's [1] and [2]. which I believe apply to any combo
   of UART+GPIO toggling.

So I hate to bring the bad news , but UART+GPIO combo toggling is really a bad
bad idea.

HTH

[1] http://comments.gmane.org/gmane.linux.serial/6770
[2] http://article.gmane.org/gmane.linux.serial/3619/

Best regards,
Marek Vasut
