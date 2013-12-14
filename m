From: anurag19aggarwal@gmail.com (Anurag Aggarwal)
Date: Sat, 14 Dec 2013 15:47:49 +0530
Subject: [PATCH V6] ARM : unwinder : Prevent data abort due to stack
 overflow
In-Reply-To: <2150956.98751386754831696.JavaMail.weblogic@epml23>
References: <2150956.98751386754831696.JavaMail.weblogic@epml23>
Message-ID: <CAPoNrtskGRsdi63cL75Pr2dTq_AepF8bPgZjSFvxRWgRgdcJBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>You could try adding some debug printks to see how the backtrace fails.
>You could also try adding a few hand-crafted assembler functions
>with appropriate code and unwind directives to trigger different kinds
>of backtrace failure.  You might have to add a way to artificially limit
>sp_high to check the cases where you run out of stack in the middle of
>popping multiple registers.

I added a a printk statement
+               if (*vsp >= (unsigned long *)ctrl->sp_high) {
+                       printk(KERN_ERR "Stack Overflow Detected, vsp = %lx",
+                               (unsigned long)*vsp);
+                       return -URC_FAILURE;
+               }

I ran a many test cases to try and get the above print in the dmesg log.

I tried the following things :

1) Calling unwind_backtrace from diffrenet locations in the kernel, I
added the unwind call
in some irq, fork, exit and some sysfs entries call.
2) I limited the value of sp_high in unwind_frame() itself, I tried
many values of sp_high,
varrying from (low + sizeof(ctrl.vrs)/4) to (low + 4*sizeof(ctrl.vrs)).

When running the above cases I was able to see the above printk quiet
a few times in dmesg log.

So, the error condition is being handled.

If you have some test cases for verifying the unwinder, please share
the same. They might help
in thorough testing of unwinder.



Regards

On Wed, Dec 11, 2013 at 3:10 PM, Anurag Aggarwal <a.anurag@samsung.com> wrote:
>>You could try adding some debug printks to see how the backtrace fails.
>>You could also try adding a few hand-crafted assembler functions
>>with appropriate code and unwind directives to trigger different kinds
>>of backtrace failure.  You might have to add a way to artificially limit
>>sp_high to check the cases where you run out of stack in the middle of
>>popping multiple registers.
>
> I added a a printk statement
> +               if (*vsp >= (unsigned long *)ctrl->sp_high) {
> +                       printk(KERN_ERR "Stack Overflow Detected, vsp = %lx",
> +                               (unsigned long)*vsp);
> +                       return -URC_FAILURE;
> +               }
>
> I ran a many test cases to try and get the above print in the dmesg log.
>
> I tried the following things :
>
> 1) Calling unwind_backtrace from diffrenet locations in the kernel, I added the unwind call
> in some irq, fork, exit and some sysfs entries call.
> 2) I limited the value of sp_high in unwind_frame() itself, I tried many values of sp_high,
> varrying from (low + sizeof(ctrl.vrs)/4) to (low + 4*sizeof(ctrl.vrs)).
>
> When running the above cases I was able to see the above printk quiet a few times in dmesg log.
>
> So, the error condition is being handled.
>
> If you have some test cases for verifying the unwinder, please share the same. They might help
> in thorough testing of unwinder.
>
>
>
> Regards
> Anurag



-- 
Anurag Aggarwal
