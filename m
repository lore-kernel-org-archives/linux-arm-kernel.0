From: pbonzini@redhat.com (Paolo Bonzini)
Date: Fri, 3 Jul 2015 09:06:17 +0200
Subject: [RFC 12/17] irq: bypass: Extend skeleton for ARM forwarding
 control
In-Reply-To: <E959C4978C3B6342920538CF579893F0025E70BF@SHSMSX104.ccr.corp.intel.com>
References: <1435843047-6327-1-git-send-email-eric.auger@linaro.org>
 <1435843047-6327-13-git-send-email-eric.auger@linaro.org>
 <E959C4978C3B6342920538CF579893F0025E6C89@SHSMSX104.ccr.corp.intel.com>
 <5596311A.3010703@redhat.com>
 <E959C4978C3B6342920538CF579893F0025E70BF@SHSMSX104.ccr.corp.intel.com>
Message-ID: <55963469.9030805@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/07/2015 09:00, Wu, Feng wrote:
>>> > > struct irq_bypass_consumer {
>>> > >        struct list_head node;
>>> > >        void *token;
>>> > > +      unsigned irq;	/*got from producer when registered*/
>>> > >        void (*add_producer)(struct irq_bypass_producer *,
>>> > >                             struct irq_bypass_consumer *);
>>> > >        void (*del_producer)(struct irq_bypass_producer *,
>>> > >                             struct irq_bypass_consumer *);
>>> > > +      void (*update)(struct irq_bypass_consumer *);
>>> > > };
>>> > >
>>> > > 'update' is used to update the IRTE, while irq is initialized when
>>> > > registered, which is used to find the right IRTE.
>> > 
>> > Feel free to add "update" in your PI patches.  I am not sure if "irq"
>> > belongs here or in the containing struct.  You can play with both and
>> > submit the version that looks better to you.
> Thanks for your review, Paolo. In my understanding, irq comes from
> the producer side, while gsi belongs to the consumer, so we need
> to get the irq from the producer somewhere. I am not sure adding
> irq here is the good way, but what I need is in the 'update' function,
> I have irq, gsi in hand. :)

It's difficult to say without seeing the patches...  The IRQ is stored
in the producer already with Eric's changes.  If you need to store the
old IRQ value, because "update" needs to do something with it, then I
think "irq" belongs in the container struct.

Perhaps "update" needs to have a producer argument as well?

Paolo
