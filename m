From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 2 Sep 2016 15:47:45 +0100
Subject: irq_create_fwspec_mapping() in 4.8-rc2
In-Reply-To: <9FCA11A3-B677-42EA-80DB-674AC8E489E8@gmail.com>
References: <483F737F-9868-4E8A-A831-AA3F6F410AFF@gmail.com>
 <57C98975.5020607@arm.com> <9FCA11A3-B677-42EA-80DB-674AC8E489E8@gmail.com>
Message-ID: <57C99111.3030105@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/16 15:29, Andras Szemzo wrote:
> Hi,
> 
>> On 02 Sep 2016, at 16:15, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>
>> So this is the interrupt that gets a mismatch.
> 
> Yes.
> 
>> Is there any other device in your system that uses the same interrupt?
>> Where can I see your full DT file?
> 
> There is no other device using pioC 11.
> Here is the DT:
> 
> http://pastebin.com/G7Z0hF5v

Can you try this patch and report the values you find?

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 4752b43..d79d780 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -623,7 +623,8 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 			return virq;
 		}
 
-		pr_warn("type mismatch, failed to map hwirq-%lu for %s!\n",
+		pr_warn("type mismatch (%u/%u), failed to map hwirq-%lu for %s!\n",
+			type, irq_get_trigger_type(virq),
 			hwirq, of_node_full_name(to_of_node(fwspec->fwnode)));
 		return 0;
 	}

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
