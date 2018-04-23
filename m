From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 23 Apr 2018 15:50:24 +0200
Subject: [PATCH] staging: bcm2835-audio: Disconnect and free
 vchi_instance on module_exit()
In-Reply-To: <20180417050028.19372-1-k.marinushkin@gmail.com>
References: <20180417050028.19372-1-k.marinushkin@gmail.com>
Message-ID: <20180423135024.GA2337@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2018 at 07:00:28AM +0200, Kirill Marinushkin wrote:
> In the current implementation, vchi_instance is inited during the first
> call of bcm2835_audio_open_connection(), and is never freed. It causes a
> memory leak when the module `snd_bcm2835` is removed.
> 
> Here is how this commit fixes it:
> 
> * the VCHI context (including vchi_instance) is created once in the
>   platform's devres
> * the VCHI context is allocated and connected once during module_init()
> * all created bcm2835_chips have a pointer to this VCHI context
> * bcm2835_audio_open_connection() can access the VCHI context through the
>   associated bcm2835_chip
> * the VCHI context is disconnected and freed once during module_exit()
> 
> After this commit is applied, I don't see other issues with the module's
> init/exit, so I also remove the associated TODO task.
> 
> Steps to reproduce the memory leak before this commit:

<snip>

Patch dropped due to kbuild complaints.

Please fix up and resend.

thanks,

greg k-h
