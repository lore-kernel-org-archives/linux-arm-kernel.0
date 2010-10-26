From: felipe.contreras@nokia.com (Felipe Contreras)
Date: Tue, 26 Oct 2010 20:03:22 +0300
Subject: [PATCH 8/8] staging: tidspbridge - make sync_wait_on_event
	interruptible
In-Reply-To: <496565EC904933469F292DDA3F1663E602F49E2802@dlee06.ent.ti.com>
References: <1288054306-4361-1-git-send-email-x0095840@ti.com>
	<1288054306-4361-2-git-send-email-x0095840@ti.com>
	<1288054306-4361-3-git-send-email-x0095840@ti.com>
	<1288054306-4361-4-git-send-email-x0095840@ti.com>
	<1288054306-4361-5-git-send-email-x0095840@ti.com>
	<1288054306-4361-6-git-send-email-x0095840@ti.com>
	<1288054306-4361-7-git-send-email-x0095840@ti.com>
	<1288054306-4361-8-git-send-email-x0095840@ti.com>
	<1288054306-4361-9-git-send-email-x0095840@ti.com>
	<AANLkTinnLb9DLMKfxEs_KqMvOmegSDYRuLWh5y=hhBCe@mail.gmail.com>
	<496565EC904933469F292DDA3F1663E602F49E2802@dlee06.ent.ti.com>
Message-ID: <1288112260-notmuch-felipe.contreras@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fernando.lugo at ti.com wrote:
> > On Tue, Oct 26, 2010 at 3:51 AM, Fernando Guzman Lugo 
> > <x0095840@ti.com> wrote:
> > > So that avoid non-killable process.
> > 
> > It would be useful to interrupt these tasks from user-space. 
> > A separate ioctl to do that would be needed.
> 
> I don't see use case where that could be needed. It is only
> To avoid a nonkillable task in the case the user pass an infinite
> Timeout.
> 
> If you have some test case where that ioctl would be needed
> Please share it in order to find the best solution.

Well, imagine the application is using a library to access the DSP, and
the library has a dedicated thread listening for DSP events in a loop.
This happens to be how libomxil-ti and gst-dsp work.

Now, the thread received the last message, but has set a timeout of 10s,
or even worst, no timeout at all.

After realizing that was the last message, the main thread decides to
shut down, but it has to wait for the DSP thread to join. Unfortunately
the DSP thread is stuck waiting for events, and there's nothing that can
be done.

However, if we have a separate ioctl to interrupt that task, then the
main thread can issue that ioctl, and unlock the DSP thread without
having to wait 10s, or forever.

Does that make sense?

-- 
Felipe Contreras
