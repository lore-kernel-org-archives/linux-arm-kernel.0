From: tbaicar@codeaurora.org (Baicar, Tyler)
Date: Tue, 27 Jun 2017 09:40:18 -0600
Subject: [PATCH v5] trace: ras: add ARM processor error information trace
 event
In-Reply-To: <20170627072555.m5ogmljp7f6lf6fu@pd.tnic>
References: <1498275503-137890-1-git-send-email-xiexiuqi@huawei.com>
 <20170626140647.anigiqhk3l6ltet7@pd.tnic>
 <22ba6506-1031-437b-95ae-c26773ff84b7@huawei.com>
 <20170627072555.m5ogmljp7f6lf6fu@pd.tnic>
Message-ID: <3e07b9f0-b2e8-cfd8-9deb-76ed48a8f2c1@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/27/2017 1:25 AM, Borislav Petkov wrote:
> On Tue, Jun 27, 2017 at 02:51:22PM +0800, Xie XiuQi wrote:
>> How about we report the full info via arm_err_info_event which just for someone
>> who want the detail information, and leave arm_event closed. If someone do not
>> care the error detail, who could just open arm_event.
> So the way I read the spec is, an error event is being described by the
> Processor Error section and then it "may contain multiple instances of
> error information structures associated to a single error event."
Hello Xie,

I originally included an error information structure in the arm_event, 
but that won't work
in the case of multiple error information structures. The spec says the 
error must contain at
least 1 error information structure, but it could be several. I'm 
unaware of a way to represent
a tracepoint with multiple structures inside of it. I figured the best 
way to do it would be
to have the arm_event TP and then a separate TP for the error 
information structure which
could be triggered several times for the same arm_event.

The same thing is true for the context information structure, but there 
could be 0 or many
of those structures. There is also an optional vendor information buffer 
that can be included,
but there is obviously only one of those. That is something that may be 
easy to add to the
arm_event TP...or do that in a separate TP as well.

Thanks,
Tyler
>
> So you can't leave the arm_event thing closed because it describes the
> event.
>
> If you want to merge the two, then sure, by all means, change arm_event
> to contain some of the processor error info structure.
>
> It wouldn't matter too much as this tracepoint is not fully cast in
> stone yet.
>
> Bottomline is, you want to carry as much information to userspace as
> possible in order to handle the error properly. But not more - you don't
> need redundant information because then that bloats the whole machinery
> around transporting and processing error records and you don't want that
> in critical situations where you want to act as quickly and as lean as
> possible.
>
> And "handle properly" means any and all actions which the kernel or
> user needs to do to prolong the system lifetime or be able to reliably
> schedule maintenance as to replace the faulty hw component. And so on
> and so on...
>
> So it all comes down to what RAS actions you guys wanna do on ARM.
>

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
