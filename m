From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Fri, 31 Oct 2014 09:31:36 +0530
Subject: [PATCH 1/2] mailbox: Avoid NULL-pointer dereference in
 mbox_chan_received_data()
In-Reply-To: <1414699267-17970-1-git-send-email-abrestic@chromium.org>
References: <1414699267-17970-1-git-send-email-abrestic@chromium.org>
Message-ID: <CAJe_ZhdiYd_aBRZeFB+vyM4PtXq=5RqqtAfwZbz0kb71XP==Jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 October 2014 01:31, Andrew Bresticker <abrestic@chromium.org> wrote:
> If a message has been received on a channel, but no client has yet bound
> to it, mbox_chan_received_data() will dereference a NULL client pointer.
> Check for the presence of a client first.
>
Let me quote from the documentation of the API ....
/**
   ....
 * After startup and before shutdown any data received on the chan
 * is passed on to the API via atomic mbox_chan_received_data().
 * The controller should ACK the RX only after this call returns.
 */
Please note "after startup and before shutdown".

We can sure suppress the crash by returning from
mbox_chan_received_data() but would that be neat? Because the real
problem lies with the controller driver that pushes data even from a
mailbox that nobody has 'enabled'.  I can see your virtual-channel
implementation needs to maintain a field for each such channel, but
for physically discreet channels it would usually be a simple matter
of setting/clearing a bit (IRQ Enable/Disable).

However, I think even for your case, you could simply set/clear the
'con_priv' instead of 'vchan_allocated' and use that hint whether to
push RX data up to the core or not.

Thanks
Jassi
