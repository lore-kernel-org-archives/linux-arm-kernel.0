From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 12 Dec 2011 11:29:20 +0000
Subject: [PATCH v5 5/9] ARM: versatile: Map local timers using Device
 Tree when possible
In-Reply-To: <4EE5E302.8070301@ru.mvista.com>
References: <1323457432-4800-1-git-send-email-pawel.moll@arm.com>
 <1323457432-4800-6-git-send-email-pawel.moll@arm.com>
 <4EE37A4D.8060204@ru.mvista.com>
 <1323687811.2391.3.camel@hornet.cambridge.arm.com>
 <4EE5E302.8070301@ru.mvista.com>
Message-ID: <1323689360.2391.15.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-12-12 at 11:18 +0000, Sergei Shtylyov wrote:
>     I think if of_iomap() fails, it's because the system is out of memory, so 
> -ENOMEM seems more proper error in this case. Although... it's not the only 
> case when of_iomap() fails.

I actually think that in this use case it's much more likely that
of_iomap() returns NULL because of_address_to_resource() fails:

void __iomem *of_iomap(struct device_node *np, int index)
{       
        struct resource res;
        
        if (of_address_to_resource(np, index, &res))
                return NULL;

and this will - again most likely - happen when np == NULL (so
of_find_compatible_node() returns nothing). That's what makes ENXIO look
good to me there...

Cheers!

Pawe?
