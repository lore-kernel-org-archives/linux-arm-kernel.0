From: davidb@codeaurora.org (David Brown)
Date: Sat, 26 Feb 2011 09:58:49 -0800
Subject: [PATCH 2/4] msm: scm: Fix improper register assignment
In-Reply-To: <20110226084736.GB3640@n2100.arm.linux.org.uk> (Russell King's
	message of "Sat, 26 Feb 2011 08:47:36 +0000")
References: <1298573085-23217-1-git-send-email-sboyd@codeaurora.org>
	<1298573085-23217-3-git-send-email-sboyd@codeaurora.org>
	<1298640219.958.74.camel@e102144-lin.cambridge.arm.com>
	<4D688AF1.1090607@codeaurora.org>
	<20110226084736.GB3640@n2100.arm.linux.org.uk>
Message-ID: <8yazkpi3cfa.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 26 2011, Russell King - ARM Linux wrote:

> On Fri, Feb 25, 2011 at 09:09:05PM -0800, Saravana Kannan wrote:
>> Yeah, Stephen and I spent quite a bit of time discussing this and  
>> experimenting to figure out what the heck GCC was doing. But it kept  
>> optimizing the fake code we put in trying to force GCC to use a specific  
>> register.
>
> One way to look at it is that if you specify a value for r0, assign it,
> and then call a function, how do you expect the r0 value to be preserved?
> r0 will be corrupted by the called function as its used to pass arg0 and
> the return value.

> I'm surprised the compiler didn't spit out an error.

The gcc docs say:

   * Local register variables in specific registers do not reserve the
     registers, except at the point where they are used as input or
     output operands in an `asm' statement and the `asm' statement
     itself is not deleted.  The compiler's data flow analysis is
     capable of determining where the specified registers contain live
     values, and where they are available for other uses.  Stores into
     local register variables may be deleted when they appear to be
     dead according to dataflow analysis.  References to local register
     variables may be deleted or moved or simplified.

which would suggest that it should at least detect that it can't keep
the value in r0.  What it seems to do is detect that the value can't be
in the register, so it never bothers putting it there in the first
place.

In any case, fortunately it works with the fix.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
