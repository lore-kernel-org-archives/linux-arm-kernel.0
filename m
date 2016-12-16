From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 16 Dec 2016 11:28:39 -0800
Subject: [PATCH 2/2] remoteproc: Remove firmware_loading_complete
In-Reply-To: <948b5b23-9440-00ef-7cf9-eca62ea93165@st.com>
References: <1481846632-4778-1-git-send-email-spjoshi@codeaurora.org>
 <1481846632-4778-2-git-send-email-spjoshi@codeaurora.org>
 <948b5b23-9440-00ef-7cf9-eca62ea93165@st.com>
Message-ID: <20161216192839.GT3439@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 16 Dec 00:26 PST 2016, loic pallardy wrote:

> 
> 
> On 12/16/2016 01:03 AM, Sarangdhar Joshi wrote:
> >rproc_del() waits on firmware_loading_complete in order to
> >make sure rproc_add() completed successfully before calling
> >rproc_shutdown().  However since rproc_add() will always be
> >called before rproc_del(), we do not need to wait on
> >firmware_loading_complete. Drop this completion variable
> >altogether.
> >
> Hi,
> 
> firmware_loading_complete is used to synchronize all operations on rproc
> with parallel work launched by request_firmware_nowait.

We had a deadlock scenario in this code, where a call to rproc_boot()
would grab the rproc mutex and the request_firmware_nowait() callback
would wait on this lock before it would signal the completion that the
rproc_boot() was waiting for.

As the request_firmware_nowait() doesn't do anything other than handle
auto_boot and signal the completion - and there is an internal sleep
mechanism for handling concurrent request_firmware calls - I posted a
patch and dropped the rproc_boot() wait thing.

> rproc_add could be done and firmware loading still pending. In that case
> rproc_del mustn't be called before end of the procedure.

You're right.

We might have an outstanding request_firmware_nowait() when we hit
rproc_del() and we might free the underlaying rproc context.

Holding a reference over the request_firmware_nowait() would solve this,
but would cause issues if we get a rproc_add() from the same driver
(e.g. after module unload/load) before the firmware timer has fired -
and released the resources.

This issue could be remedied by moving the rproc_delete_debug_dir() to
rproc_del() and aim for not having any objects exposed outside the
remoteproc core once rproc_del() returns.

> 
> If you decide to remove this synchronization you need either to modify rproc
> boot sequence or to replace it by something else.
> 

I agree.

Regards,
Bjorn
