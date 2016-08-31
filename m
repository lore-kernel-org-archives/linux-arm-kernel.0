From: james.morse@arm.com (James Morse)
Date: Wed, 31 Aug 2016 08:35:49 +0100
Subject: [PATCH] arm64: kernel: Fix unmasked debug exceptions when
 restoring mdscr_el1
In-Reply-To: <20160826163947.GB23885@red-moon>
References: <1472223822-21059-1-git-send-email-james.morse@arm.com>
 <20160826163947.GB23885@red-moon>
Message-ID: <57C688D5.2040400@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On 26/08/16 17:39, Lorenzo Pieralisi wrote:
> On Fri, Aug 26, 2016 at 04:03:42PM +0100, James Morse wrote:
>> Changes to make the resume from cpu_suspend() code behave more like
>> secondary boot caused debug exceptions to be unmasked early by
>> __cpu_setup(). We then go on to restore mdscr_el1 in cpu_do_resume(),
>> potentially taking break or watch points based on uninitialised registers.
> 
> Another option would be moving enable_dbg() out of __cpu_setup() and
> calling when it returns in the cold boot path, that would not change
> much in terms of debugging but we would avoid fiddling about with
> daif three times in the resume path just to restore it to what it
> was on suspend entry :)

I agree, but there is/will-be quite a lot of churn in the code that calls
enable_mmu() if Ard's cleanup series is taken. I think this is the tidiest fix
to backport. I will post a patch to tidy this up as you suggest for v4.9-rc1.


Thanks,

James
