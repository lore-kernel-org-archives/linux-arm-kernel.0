From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 7 Oct 2011 15:28:14 -0600
Subject: [PATCH 2/5] drivercore: Add driver probe deferral mechanism
In-Reply-To: <20111007064928.GE27508@kroah.com>
References: <1317963790-29426-1-git-send-email-manjugk@ti.com>
	<1317963790-29426-3-git-send-email-manjugk@ti.com>
	<20111007064928.GE27508@kroah.com>
Message-ID: <CACxGe6v_QC4v7omN_bMJi1=46Ww+EdLJ7OiAwpWLWYM6v_cqBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 7, 2011 at 12:49 AM, Greg KH <greg@kroah.com> wrote:
> On Fri, Oct 07, 2011 at 10:33:07AM +0500, G, Manjunath Kondaiah wrote:
>> +config PROBE_DEFER
>> + ? ? bool "Deferred Driver Probe"
>> + ? ? default y
>> + ? ? help
>> + ? ? ? This option provides deferring driver probe if it has dependency on
>> + ? ? ? other driver. Without this feature, initcall ordering should be done
>> + ? ? ? manually to resolve driver dependencies. This feature completely side
>> + ? ? ? steps the issues by allowing driver registration to occur in any
>> + ? ? ? order, and any driver can request to be retried after a few more other
>> + ? ? ? drivers get probed.
>
> Why is this even an option? ?Why would you ever want it disabled? ?Why
> does it need to be selected?
>
> If you are going to default something to 'y' then just make it so it
> can't be turned off any other way by just not making it an option at
> all.
>
> It also cleans up this diff a lot, as you really don't want #ifdef in .c
> files.

Okay, we'll drop the kconfig

>> + ? ? ?* This bit is tricky. ?We want to process every device in the
>> + ? ? ?* deferred list, but devices can be removed from the list at any
>> + ? ? ?* time while inside this for-each loop. ?There are two things that
>> + ? ? ?* need to be protected against:
>
> That's what the klist structure is supposed to make easier, why not use
> that here?
>
>> + ? ? ?* - if the device is removed from the deferred_probe_list, then we
>> + ? ? ?* ? loose our place in the loop. ?Since any device can be removed
>> + ? ? ?* ? asynchronously, list_for_each_entry_safe() wouldn't make things
>> + ? ? ?* ? much better. ?Simplest solution is to restart walking the list
>> + ? ? ?* ? whenever the current device gets removed. ?Not the most efficient,
>> + ? ? ?* ? but is simple to implement and easy to audit for correctness.
>> + ? ? ?* - if the device is unregistered, and freed, then there is a risk
>> + ? ? ?* ? of a null pointer dereference. ?This code uses get/put_device()
>> + ? ? ?* ? to ensure the device cannot disappear from under our feet.
>
> Ick, use a klist, it was created to handle this exact problem in the
> driver core, so to not use it would be wrong, right?

This comment block is stale.  I reworked the code before I handed it
off to Manjunath, but I never rewrote the comment.  The current code
uses a pair of list to keep deferred devices separate from devices
currently being probed, and the problem described above no longer
exists.  However, Manjunath and I will look into switching from the
two list design to using klist.

Thanks for the feedback.
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
