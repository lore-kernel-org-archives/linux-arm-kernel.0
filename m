From: mika.j.penttila@gmail.com (=?UTF-8?Q?Mika_Penttil=C3=A4?=)
Date: Tue, 1 Sep 2015 17:14:37 +0300
Subject: No subject
Message-ID: <CAChTCPz8_2ddsuBgVF0VX-a7Lp=WHWP+W3nyzQgi+g9Tj2EZvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This one causes imx6q with debug uart connected to "schedule while
atomic" endlessly :


9e7b399d6528eac33a6fbfceb2b92af209c3454d is the first bad commit
commit 9e7b399d6528eac33a6fbfceb2b92af209c3454d
Author: Eduardo Valentin <edubezval@gmail.com>
Date:   Tue Aug 11 10:21:20 2015 -0700

    serial: imx: remove unbalanced clk_prepare

    The current code attempts to prepare clk_per and clk_ipg
    before using the device. However, the result is an extra
    prepare call on each clock. Here is the output of uart
    clocks (only uart enabled and used as console):

    $  grep uart /sys/kernel/debug/clk/clk_summary
     uart_serial           1            2    80000000          0 0
           uart           1            2    66000000          0 0

    This patch balances the calls of prepares. The result is:

    $  grep uart /sys/kernel/debug/clk/clk_summary
     uart_serial           1            1    80000000          0 0
           uart           1            1    66000000          0 0

    Cc: Fabio Estevam <festevam@gmail.com>
    Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Cc: Jiri Slaby <jslaby@suse.com>
    Cc: linux-serial at vger.kernel.org
    Cc: linux-pm at vger.kernel.org
    Cc: linux-kernel at vger.kernel.org
    Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
