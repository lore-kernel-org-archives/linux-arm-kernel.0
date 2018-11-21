From: Al.Grant@arm.com (Al Grant)
Date: Wed, 21 Nov 2018 16:23:48 +0000
Subject: [RFC PATCH 1/3] drivers: amba: Updates to component
 identification for driver matching.
In-Reply-To: <CAJ9a7ViFRUuZQnqvtEO-OOjSGY45e7vxgPn0cTC6wnZw9ij9xg@mail.gmail.com>
References: <20181115012842.2353-1-mike.leach@linaro.org>
 <20181115012842.2353-2-mike.leach@linaro.org> <20181120205737.GA17267@xps15>
 <CAJ9a7VjD1C3t=OtCpQNGvmSvDh-vPcR_2mObccJJ1Qv8_9BxFw@mail.gmail.com>
 <AM6PR08MB36868BDA513BA392E01EDE9D86DA0@AM6PR08MB3686.eurprd08.prod.outlook.com>
 <CAJ9a7ViFRUuZQnqvtEO-OOjSGY45e7vxgPn0cTC6wnZw9ij9xg@mail.gmail.com>
Message-ID: <AM6PR08MB3686102303EB6DCF7D004C0F86DA0@AM6PR08MB3686.eurprd08.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > The architect field defines what the ARCHID field means (the ARCHID
> > values are specific to each architect), it's not the same as the
> > implementer field. You need to check both if you want to know what
> > component driver to use. The correct mask for that is 0xfff0ffff.
>
> This is a fair point - thought at present the peripheral ID matching takes in the
> JDEC ID code of the component designer - in the ETM case ARM (though without
> a JDEC continuation code check).
> Given this field too is specified as "designer not implementer", it seems logically
> unlikely that designer != architect.

It might be exactly like that. On the system I'm using right now:

  DEVARCH=0x47714a13  meaning architect=ARM architecture=ETM
  PIDR= <somebody else>

This is not a Cortex core designed by ARM, it's someone else's ARM
compatible core and they designed their own ARM-compatible ETM.
It conforms to the ETM architecture defined by ARM, so they set
DEVARCH to indicate that (architect=ARM), but in the implementer/
designer code in PIDR they put their own JEDEC code.

If you've got DEVARCH, that should be all you need to select the right
driver and then the driver should be able to get everything it needs
from the feature ID regs. It should only need to look at implementer
code / product code as a last resort for errata workarounds or similar
(e.g. if the feature ID regs are known to be incorrect).

If you haven't got DEVARCH, you have to look at implementer code /
product code. So for example if we see a componet with no DEVARCH
but with designer=ARM product=0x961, that's "ARM product 0x961"
i.e. a TMC, and we can write the driver according to the programming
interface described in the manual for that product.

Al



>
> If we did feel the need to alter the match value / mask values - this happens in
> the CS driver code, not in this patch - so will need to be addressed there.
>
> Thanks
>
> Mike
>
> > Al
> > IMPORTANT NOTICE: The contents of this email and any attachments are
> confidential and may also be privileged. If you are not the intended recipient,
> please notify the sender immediately and do not disclose the contents to any
> other person, use it for any purpose, or store or copy the information in any
> medium. Thank you.
>
>
>
> --
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
