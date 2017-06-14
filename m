From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Wed, 14 Jun 2017 13:38:04 +0000
Subject: [PATCH v7 10/10] staging: fsl-mc: move bus driver out of staging
In-Reply-To: <20170613102215.GA5866@kroah.com>
References: <20170608142855.10455-1-laurentiu.tudor@nxp.com>
 <20170608142855.10455-11-laurentiu.tudor@nxp.com>
 <20170613102215.GA5866@kroah.com>
Message-ID: <59413C3A.1010306@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On 06/13/2017 01:22 PM, Greg KH wrote:
> On Thu, Jun 08, 2017 at 05:28:55PM +0300, laurentiu.tudor at nxp.com wrote:
>> From: Stuart Yoder <stuart.yoder@nxp.com>
>>
>> Move the source files out of staging into their final locations:
>>    -include files in drivers/staging/fsl-mc/include go to include/linux/fsl
>>    -irq-gic-v3-its-fsl-mc-msi.c goes to drivers/irqchip
>
> Why do you have so many different .h files?  You should only need 1
> "external" one, and one "internal" one, right?  Can you please work on
> cleaning that up first?
>

So here's the list of headers, for quick reference.

dpbp.h
dpcon-cmd.h
dpmng.h
dprc.h
mc-bus.h
mc-cmd.h
mc-sys.h
mc.h

And here's a proposal on how to reorganize them:

  - dpbp.h (together with dbbp.c) be left behind in staging as they are
    not used by the bus itself but by the drivers probing on this bus.
    They will be moved out of staging at a later time.
  - same for dpcon-cmd.h. Will handle it when we'll start work on
    getting dpcon.c & dpcon.h out of staging.
  - dprc.h contains APIs for handling mc-bus "device containers" that are
    managed by the mc-bus driver itself. I'd leave this as is, but i
    think i can make it private.
  - regarding the multiple mc*.h files, i'll see what it takes to
    refactor them in a mc-bus.h + mc-bus-private.h
  - dpmng.h merged in the public header

Regarding the future plans for dpbp.h and dpcon.h, these expose common 
APIs used throughout all the drivers, so i think it makes sense to leave 
them as they are and, when their time comes, move them in the public 
include/linux/fsl.

---
Thanks & Best Regards, Laurentiu
