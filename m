From: etienne.carriere@st.com (Etienne CARRIERE ST)
Date: Wed, 14 Nov 2012 11:13:50 +0100
Subject: [PATCH 1/2] arm/mm: L2CC shared mutex with ARM TZ
In-Reply-To: <20121113171745.GA6370@linaro.org>
References: <0154077FE026E54BB093CA7EB3FD1AE32B57AF1B59@SAFEX1MAIL3.st.com>
 <20121113171745.GA6370@linaro.org>
Message-ID: <0154077FE026E54BB093CA7EB3FD1AE32DB61E4CC3@SAFEX1MAIL3.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Tue 11-13-2012 6:18 PM
> From:  Dave Martin <dave.martin@linaro.org>
>
> > Secure code in TrustZone space may need to perform L2 cache
> > maintenance operations. A shared mutex is required to synchronize
> > linux l2cc maintenance and TZ l2cc maintenance.
>
> 1) Why is this not a denial-of-service risk?  (i.e., why can the Normal 
> World not simply hold the mutex forever?)

On SoC's, it is likely that some HW IP are controlled with ARM NS compliant HW support, thus needed for TZ execution (RAMs, ...).
It is likely that nonTZ world, in such situation, could disable a clock, regulator, ... and arm TZ executions, including cache content.
An easy "secu denial of service" hack, is just to reprogram linux based OS to prevent any or selected calls to secure code.
Since linux OS is an untrusted environment, one could just reprogram it to prevent call to secure tagged features.

It is the responsibility of the TZ implementation to insure that secure content is not corrupted nor accessed to from nonTZ world.

> 2) The memory types on both sides have to be _exactly_ the same, 
> not just "cached", otherwise unpredictable behaviour may occur when 
> accessing the mutex.  It is not obvious how this is ensured.

Ok, I will cross check this.
The mapping of the mutex/spinlock "lock" field is under responsibility of the TZ API driver. 
Each platform TZ API should define the expected mapping configuration.

> 3) Many people seem to delegate L2 cache maintenence requests 
> via SMC in these situations.  Can you do that instead?

We can have code that runs in TZ world and heavily processes data, benefitting from cache support, then needing the flush data to DDR.
In such case, TZ would not need to request linux to request cache line maintenance.

Regards,
Etienne

> 
> Cheers
> ---Dave 
