From: will.deacon@arm.com (Will Deacon)
Date: Thu, 16 Nov 2017 11:51:39 +0000
Subject: [GIT PULL] arm64: updates for 4.15
In-Reply-To: <CA+55aFxnePDimkVKVtv3gNmRGcwc8KQ5mHYvUxY8sAQg6yvVYg@mail.gmail.com>
References: <20171114201132.GB18699@arm.com>
 <CA+55aFxnePDimkVKVtv3gNmRGcwc8KQ5mHYvUxY8sAQg6yvVYg@mail.gmail.com>
Message-ID: <20171116115138.GF9361@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Wed, Nov 15, 2017 at 11:13:51AM -0800, Linus Torvalds wrote:
> On Tue, Nov 14, 2017 at 12:11 PM, Will Deacon <will.deacon@arm.com> wrote:
> >
> > Please pull the following arm64 updates
> 
> Pulled. However, looking at the non-arm changes, I noticed this:
> 
>   static inline int irq_is_percpu_devid(unsigned int irq)
>   ...
>          return desc->status_use_accessors & IRQ_PER_CPU_DEVID;
> 
> and it matches the existing pattern in that file, so it is fine and
> I'm not complaining about this pull.

Thanks.

> But that existing pattern happens to be very dangerous and bad.
> 
> In particular, what can (and _has_ happened) is that people end up
> using these functions that return true or false, and they assign the
> result to something like a bitfield (or a char) or whatever.
> 
> And the code looks *obviously* correct, when you have things like
> 
>      dev->percpu = irq_is_percpu_devid(dev->irq);
> 
> and that "percpu" thing is just one status bit among many. It may even
> *work*, because maybe that "percpu" flag ends up not being all that
> important, or it just happens to never be set on the particular
> hardware that people end up testing.
> 
> But while it looks obviously correct, and might even work, it's really
> fundamentally broken. Because that "true or false" function didn't
> actually return 0/1, it returned 0 or 0x20000.
> 
> And 0x20000 may not fit in a bitmask or a "char" or whatever.
> 
> So I'm not a huge fan of "bool" in structures etc (a "unsigned int
> percpu:1" really is fundamentally much better), but when it comes to
> inline helper functions like this, "bool" really is the right return
> type, because it avoids these issues, and turns the return value to
> 0/1 if you actually use it in an integer context.

Yes, that makes sense and just returning bool matches the code in
kernel/irq/settings.h which is the other direct user of
status_use_accessors. The small handful of callers also treat the returned
value as a bool (as you'd expect), so we're good.

Patch below.

Will

--->8

>From a13a3e00d86d9f8d2af330d7a5165197166c37ce Mon Sep 17 00:00:00 2001
From: Will Deacon <will.deacon@arm.com>
Date: Thu, 16 Nov 2017 10:49:34 +0000
Subject: [PATCH] irqdesc: Use bool return type instead of int

The irq_balancing_disabled and irq_is_percpu{,_devid} functions are
clearly intended to return bool like the functions in
kernel/irq/settings.h, but actually return an int containing a masked
value of desc->status_use_accessors. This can lead to subtle breakage
if, for example, the return value is subsequently truncated when
assigned to a narrower type.

As Linus points out:

| In particular, what can (and _has_ happened) is that people end up
| using these functions that return true or false, and they assign the
| result to something like a bitfield (or a char) or whatever.
|
| And the code looks *obviously* correct, when you have things like
|
|      dev->percpu = irq_is_percpu_devid(dev->irq);
|
| and that "percpu" thing is just one status bit among many. It may even
| *work*, because maybe that "percpu" flag ends up not being all that
| important, or it just happens to never be set on the particular
| hardware that people end up testing.
|
| But while it looks obviously correct, and might even work, it's really
| fundamentally broken. Because that "true or false" function didn't
| actually return 0/1, it returned 0 or 0x20000.
|
| And 0x20000 may not fit in a bitmask or a "char" or whatever.

Fix the problem by consistently using bool as the return type for these
functions.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/linux/irqdesc.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index dd418955962b..39fb3700f7a9 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -230,7 +230,7 @@ irq_set_chip_handler_name_locked(struct irq_data *data, struct irq_chip *chip,
 	data->chip = chip;
 }
 
-static inline int irq_balancing_disabled(unsigned int irq)
+static inline bool irq_balancing_disabled(unsigned int irq)
 {
 	struct irq_desc *desc;
 
@@ -238,7 +238,7 @@ static inline int irq_balancing_disabled(unsigned int irq)
 	return desc->status_use_accessors & IRQ_NO_BALANCING_MASK;
 }
 
-static inline int irq_is_percpu(unsigned int irq)
+static inline bool irq_is_percpu(unsigned int irq)
 {
 	struct irq_desc *desc;
 
@@ -246,7 +246,7 @@ static inline int irq_is_percpu(unsigned int irq)
 	return desc->status_use_accessors & IRQ_PER_CPU;
 }
 
-static inline int irq_is_percpu_devid(unsigned int irq)
+static inline bool irq_is_percpu_devid(unsigned int irq)
 {
 	struct irq_desc *desc;
 
-- 
2.1.4
