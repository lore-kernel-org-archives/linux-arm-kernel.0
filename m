From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 8 Feb 2012 12:12:32 +0100
Subject: [PATCH v2 02/10] pwm: Allow chips to support multiple PWMs.
In-Reply-To: <20120208091327.GH889@n2100.arm.linux.org.uk>
References: <1328541585-24642-1-git-send-email-thierry.reding@avionic-design.de>
 <1328541585-24642-3-git-send-email-thierry.reding@avionic-design.de>
 <4F3044A9.8000202@metafoo.de>
 <20120207070400.GA29238@avionic-0098.mockup.avionic-design.de>
 <20120208091327.GH889@n2100.arm.linux.org.uk>
Message-ID: <20120208111232.GB17615@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux wrote:
> On Tue, Feb 07, 2012 at 08:04:00AM +0100, Thierry Reding wrote:
> > One of the major problems when converting to a non-global namespace is how to
> > represent the relationship in code. For device tree this should be easy to do
> > because it has all the infrastructure in place. For non-device-tree devices I
> > have no idea yet how this could be done. Perhaps by using something like the
> > clock API and using names for lookup?
> 
> Well, the first step is to make sure that the pwm 'chip' drivers don't
> know anything about the global numberspace.
> 
> That limits the extent of the global numberspace to the pwm core and
> pwm users.  You then don't have to worry about the pwm chip drivers
> while you work out how to solve the other half of the problem.

I see. That would mean that pwm_request() gets a global PWM index, looks up
the corresponding PWM chip and device then pass the chip-relative index to
the driver's ops.

I think that can be simplified even further. For instance if the pwm_device
structure contains a pointer to its parent struct pwm_chip, then that can be
used directly to call into the driver's ops. And the ops could be modified to
take a pwm_device instead of the global PWM index. That would be similar to
how struct irq_data is used.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120208/57c89e5a/attachment.sig>
