From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 22 Jul 2015 13:43:34 +0100
Subject: [PATCH 1/5] genirq: irqdomain: Use an accessor for the of_node
 field
In-Reply-To: <alpine.DEB.2.11.1507220958090.18576@nanos>
References: <1437473280-11431-1-git-send-email-marc.zyngier@arm.com>
 <1437473280-11431-2-git-send-email-marc.zyngier@arm.com>
 <55AF47D7.8010304@linaro.org> <55AF4BBA.5030209@arm.com>
 <alpine.DEB.2.11.1507220958090.18576@nanos>
Message-ID: <55AF8FF6.3080901@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/07/15 08:58, Thomas Gleixner wrote:
> On Wed, 22 Jul 2015, Marc Zyngier wrote:
>>
>> Looks like my coccinelle foo is still lacking a bit... Oh well.
> 
> Please post your semantic patch and don't forget to Cc Julia Lawall :)
> 

Bah, found the problem. My semantic patch is extremely simple:

@init@
struct irq_domain *ptr;
position pos;
@@

(
ptr at pos->of_node
)


@ script:python @
p1 << init.pos;
@@

for p in p1:
    print "%s:%s" % (p.file,p.line)

as I'm just grepping through the tree (I don't feel confident enough to
do the patching, and some cases are a bit more complicated).

But I forgot to add arch/$ARCH/include/asm as an include search path for
spatch. That had the side effect of spatch being unable to identify
constructs like:

arch/$ARCH/include/asm/foo.h:

	struct foo {
		struct irq_domain *bar;
	};

arch/$ARCH/.../foo.c:

	struct foo foo;
	if (foo->bar->of_node) { ... }

Since spatch knows nothing about struct foo, it cannot identify bar as a
struct irq_domain, hence missing this occurrence.

Once I fixed the include path, I found an additional couple of victims.
I really love this thing! :-)

	M.
-- 
Jazz is not dead. It just smells funny...
