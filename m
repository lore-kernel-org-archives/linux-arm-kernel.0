From: ryanschaefer23@gmail.com (Ryan Schaefer)
Date: Thu, 3 Aug 2017 09:10:45 -0700
Subject: i.mx7: Changing linux,usable-memory causes BUG: Bad Page
In-Reply-To: <20170802200703.rnr4ucjy5c7dnhuf@pengutronix.de>
References: <CAN1Oqpw835L3Rc-J59_qSJ3toUWH8TD00r=ZcN6quvcnE8mnHQ@mail.gmail.com>
 <20170802200703.rnr4ucjy5c7dnhuf@pengutronix.de>
Message-ID: <CAN1OqpzgtzAq5Lm1O7p1pPRiakARuXPWAfVZGhsN48vCka34Ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Wed, Aug 2, 2017 at 1:07 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello Ryan,
>
> On Wed, Aug 02, 2017 at 09:11:14AM -0700, Ryan Schaefer wrote:
>> I am using an i.mx7d based board, and attempting to reserve the lower
>> 2MB of memory for the M4 co-processor.
>
> Linux expects TAM starting at a 128 MiB boundary in some places. So,
> does it work if you reserve 128 MiB for the M4?

I've tried booting with the following memory node (and only one
dynamic reserved-memory node for cma)

memory {
        linux,usable-memory = <0x88000000 0x37f00000>;
};

The kernel hangs at "Uncompressing Linux... done, booting the
kernel.". I thought this was because TEXT_OFFSET is 0x00208000, which
is outside of usable-memory. The kernel will not compile after
changing TEXT_OFFSET to 0x08008000. Compiler error below:

"arch/arm/kernel/head.S:164: Error: invalid constant (8008000) after fixup"

Isn't there a rule that the kernel must be within 16MB of the start of DDR?

Thanks,
Ryan
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
