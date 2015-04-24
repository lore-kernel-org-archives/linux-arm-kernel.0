From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 Apr 2015 16:54:01 +0200
Subject: [RFC PATCH] bus: mvebu-mbus: do not set WIN_CTRL_SYNCBARRIER on
 non io-coherent platforms.
In-Reply-To: <1429886671-14415-1-git-send-email-nschichan@freebox.fr>
References: <20150417132350.329bcace@free-electrons.com>
 <1429886671-14415-1-git-send-email-nschichan@freebox.fr>
Message-ID: <20150424165401.733666b4@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Nicolas Schichan,

On Fri, 24 Apr 2015 16:44:31 +0200, Nicolas Schichan wrote:
> On those platforms (orion5x, kirkwood and dove AFAICS) the
> WIN_CTRL_SYNCBARRIER bit in the window control register is either
> reserved (all windows except 6 and 7) or enables read-only protection
> (windows 6 and 7).
> 
> Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
> ---
> 
> Hello Thomas,
> 
> Please find here my attempt at fixing this. I have been relying on the
> hw_io_coherency field of the struct mvebu_mbus_state which is always
> false for the platforms without the WIN_CTRL_SYNCBARRIER bit available
> (orion5x, kirkwood, and dove).
> 
> I was going to add a field to mvebu_soc_data documenting the
> availability of the WIN_CTRL_SYNCBARRIER bit for each platform but for
> that purpose, the mvebu_mbus_state struct hw_io_coherency field looks
> to be enough.
> 
> This has been tested on mv88f6282 (kirkwood).

Thanks, it looks good to me. Can you resend with:

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: <stable@vger.kernel.org> # v4.0+
Fixes: a0b5cd4ac2d6 ("bus: mvebu-mbus: use automatic I/O synchronization barriers")

An addition to the commit log like:

Commit a0b5cd4ac2d6 ("bus: mvebu-mbus: use automatic I/O
synchronization barriers") enabled the usage of automatic I/O
synchronization barriers by enabling bit WIN_CTRL_SYNCBARRIER in the
control registers of MBus windows, but....

And in the code, maybe add a comment above the WIN_CTRL_SYNCBARRIER
definition like:

/* Only on HW I/O coherency capable platforms */
#define WIN_CTRL_SYNCBARRIER ...

Thanks a lot!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
