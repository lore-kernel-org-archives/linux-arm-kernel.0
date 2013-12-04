From: alex.elder@linaro.org (Alex Elder)
Date: Wed, 04 Dec 2013 07:57:39 -0600
Subject: [PATCH 2/3] clk: bcm281xx: add initial clock framework support
In-Reply-To: <529F28E3.90905@linaro.org>
References: <529EA78E.7060904@linaro.org> <529EA80F.3050009@linaro.org>
 <20131204111457.GF16025@e106331-lin.cambridge.arm.com>
 <529F28E3.90905@linaro.org>
Message-ID: <529F34D3.5080806@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/2013 07:06 AM, Alex Elder wrote:
>>> +       name_size = strlen(node->name) + 1;
>>> >> +       ccu = kzalloc(sizeof(*ccu) + name_size, GFP_KERNEL);
>>> >> +       if (!ccu) {
>>> >> +               pr_err("%s: unable to map allocate CCU struct for %s\n",
>>> >> +                       __func__, node->name);
>>> >> +               return;
>>> >> +       }
>>> >> +       memcpy((char *)ccu->name, node->name, name_size);
>> > 
>> > You could simplify this with kstrdup.
> You are correct, and I will make that change.  I think at
> one point I needed the length but that doesn't appear to
> be the case here.

On second thought, no, you may have missed what was happening here.
I was avoiding two kmallocs() by setting aside space at the end
of the structure to hold its name.  It may seem silly, but this
avoids a possible (well, conceivable) failure case.

However, based on your earlier question about "what about freeing
ccu->name?" I am going to use kstrdup() here.  I'd rather the code
put you at ease than look weird just to avoid an unlikely failure.

					-Alex
