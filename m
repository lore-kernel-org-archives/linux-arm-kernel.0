From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 19 Jan 2014 20:34:51 +0100
Subject: [RFC v3 04/13] ahci-platform: Undo pdata->resume on resume failure
In-Reply-To: <20140119191349.GA32165@mtj.dyndns.org>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-5-git-send-email-hdegoede@redhat.com>
 <20140119112737.GC11123@htj.dyndns.org> <52DC1C15.1030107@redhat.com>
 <20140119191349.GA32165@mtj.dyndns.org>
Message-ID: <52DC28DB.7070804@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/19/2014 08:13 PM, Tejun Heo wrote:
> Hello,
>
> On Sun, Jan 19, 2014 at 07:40:21PM +0100, Hans de Goede wrote:
>> That sounds like your advocating for just returning from resume on the
>> first error without undoing any of the previous steps, have I gotten that
>> right?
>
> Yeah, or just ignore reset failure and proceed.

That seems like a bad idea IMHO, if reset failed something is seriously
amiss and just continuing as nothing happened seems unhelpful.

>> That sounds as sensible as any other approach on resume errors
>> (there are IMHO no good answers), if that is what you mean, shall I do a
>
> Suspending back is the wrong answer tho.
>
>> patch in the next versions of my patch-set doing that ?
>
> Isn't just dropping this patch enough tho?

Well the current error handling still re-disables the clks on resume failure,
if you want to proceed with resume as far as possible, rather then return to
a suspended state it seems sensible to just leave the clocks on as well.

Also disabling the clocks on resume failure, followed by a rmmod will cause
a WARN_ON to trigger in the clock-framework when ahci_host_stop tries to
disable the clks for a second time.

Regards,

Hans
