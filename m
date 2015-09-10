From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 10 Sep 2015 22:53:43 +0200
Subject: [PATCH] ARM: fix alignement of __bug_table section entries
References: <87y4gkx04m.fsf@belgarion.home>
 <20150905203818.GO21084@n2100.arm.linux.org.uk>
 <87lhcjwjde.fsf@belgarion.home>
 <20150906194805.GP21084@n2100.arm.linux.org.uk>
 <87egibw7yh.fsf@belgarion.home>
 <20150906235414.GQ21084@n2100.arm.linux.org.uk>
 <877fo0x2ur.fsf@belgarion.home>
 <20150908200809.GC21084@n2100.arm.linux.org.uk>
 <87mvwvurae.fsf@belgarion.home> <87egi6umi2.fsf@belgarion.home>
 <20150910191652.GJ21084@n2100.arm.linux.org.uk>
Message-ID: <8737ymuhbc.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> I've been wondering whether we can teach GCC that set_domain modifies
> the value that get_domain returns, rather than throwing a volatile
> onto the asm in get_domain.  The issue with a volatile there is that
> even if the result is unused, but the code is reachable, gcc still has
> to output the code to read the register.
>
> We might be able to get away with a memory clobber on the set_domain,
> and fake a memory read in get_domain, eg, by passing
> 	"m" (current_thread_info()->cpu_domain))
> to the get_domain asm.
Ok, let's say we do it that way.

I have some concerns about it:
  (a) I see an inbalance, as set_domain() doesn't actually modify
      current_thread_info()->cpu_domain. I don't see how it will protect use
      from this scenario :
        - get_domain()
        - set_domain()
        - set_domain()

  (b) domain.h is included from thread_info.h, not the other way around
      => current_thread_info() is not accessible from domain.h
      => that would require a bit of moving things around, as thread_info
         structure description should be available for example.
      This is currently my biggest problem with this approach.

  (c) I was also wondering if a case like this could happen :
     - a function foo() does a get_domain()
       => an exception/irq whatever happens and modifies the DACR
     - foo() continues a makes a modify_domain()
       => and here the modify_domain() uses the old DACR value
      Or said differently, I wonder if there is a case of 2 get_domain() calls
      in a row with a DACR modification in between. I

What about something such as [1], without a memory clobber, but a "fake" memory
variable link ?

Cheers.

--
Robert

[1] get_domain() / set_domain() link
diff --git a/arch/arm/include/asm/domain.h b/arch/arm/include/asm/domain.h
index e878129f2fee..fc1d9c43aa08 100644
--- a/arch/arm/include/asm/domain.h
+++ b/arch/arm/include/asm/domain.h
@@ -83,13 +83,17 @@
 
 #ifndef __ASSEMBLY__
 
+static int domain_barrier;
+/*
+ * how to get the current stack pointer in C
+ */
 static inline unsigned int get_domain(void)
 {
        unsigned int domain;
 
        asm(
        "mrc    p15, 0, %0, c3, c0      @ get domain"
-        : "=r" (domain));
+        : "=r" (domain), "=m" (domain_barrier));
 
        return domain;
 }
@@ -97,8 +101,8 @@ static inline unsigned int get_domain(void)
 static inline void set_domain(unsigned val)
 {
        asm volatile(
-       "mcr    p15, 0, %0, c3, c0      @ set domain"
-         : : "r" (val));
+       "mcr    p15, 0, %1, c3, c0      @ set domain"
+       : "=m" (domain_barrier) : "r" (val));
        isb();
 }
