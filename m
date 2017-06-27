From: bp@suse.de (Borislav Petkov)
Date: Tue, 27 Jun 2017 09:25:55 +0200
Subject: [PATCH v5] trace: ras: add ARM processor error information trace
 event
In-Reply-To: <22ba6506-1031-437b-95ae-c26773ff84b7@huawei.com>
References: <1498275503-137890-1-git-send-email-xiexiuqi@huawei.com>
 <20170626140647.anigiqhk3l6ltet7@pd.tnic>
 <22ba6506-1031-437b-95ae-c26773ff84b7@huawei.com>
Message-ID: <20170627072555.m5ogmljp7f6lf6fu@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 27, 2017 at 02:51:22PM +0800, Xie XiuQi wrote:
> How about we report the full info via arm_err_info_event which just for someone
> who want the detail information, and leave arm_event closed. If someone do not
> care the error detail, who could just open arm_event.

So the way I read the spec is, an error event is being described by the
Processor Error section and then it "may contain multiple instances of
error information structures associated to a single error event."

So you can't leave the arm_event thing closed because it describes the
event.

If you want to merge the two, then sure, by all means, change arm_event
to contain some of the processor error info structure.

It wouldn't matter too much as this tracepoint is not fully cast in
stone yet.

Bottomline is, you want to carry as much information to userspace as
possible in order to handle the error properly. But not more - you don't
need redundant information because then that bloats the whole machinery
around transporting and processing error records and you don't want that
in critical situations where you want to act as quickly and as lean as
possible.

And "handle properly" means any and all actions which the kernel or
user needs to do to prolong the system lifetime or be able to reliably
schedule maintenance as to replace the faulty hw component. And so on
and so on...

So it all comes down to what RAS actions you guys wanna do on ARM.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imend?rffer, Jane Smithard, Graham Norton, HRB 21284 (AG N?rnberg)
-- 
