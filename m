From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 29 Jun 2016 09:23:13 +0200
Subject: clk: Per controller locks (prepare & enable)
Message-ID: <57737761.2020708@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


Problems:
1. Deadlocks on prepare lock in following scenario:
 - prepare_enable(some external clock through i2c)
   - i2c transfer
     - prepare_enable(i2c lock in SoC)
       - deadlock
See [1]. We implemented a workaround for this in few places like
10ff4c5239a1 ("i2c: exynos5: Fix possible ABBA deadlock by keeping I2C
clock prepared") and 34e81ad5f0b6 ("i2c: s3c2410: fix ABBA deadlock by
keeping clock prepared")

The goal would be to remove also this workaround.

2. The global prepare and enable locks are over-used. I didn't test the
congestion but intuition says that they could be improved.


Solution:
Make this locks per controller. This will directly solve problem #1
because these are different controllers. Still in-controller deadlock
could occur but we couldn't find a real case with it.


Question:
What do you think about it? I know that talk is cheap and code looks
better but before starting the work I would like to hear some
comments/opinions/ideas.


Best regards,
Krzysztof


[1]
http://www.krzk.eu/builders/boot-odroid-xu3-multi_v7/builds/34/steps/Boot%20odroid/logs/serial
