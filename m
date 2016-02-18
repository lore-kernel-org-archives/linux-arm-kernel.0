From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Feb 2016 10:21:48 +0100
Subject: [PATCH] staging: rtl8712: reduce stack usage
In-Reply-To: <56C52A5F.2030302@lwfinger.net>
References: <1455698012-814399-1-git-send-email-arnd@arndb.de>
 <56C52A5F.2030302@lwfinger.net>
Message-ID: <3642222.ppVDPONLa4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 February 2016 20:20:15 Larry Finger wrote:
> > ---
> >   drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> As there is no reason for translate_scan() to be inlined, this patch seems 
> reasonable The largest user of stack likely comes from the line "struct iw_event 
> iwe". Changing that to a pointer, and using kalloc to acquire the space would 
> likely clear the compile message, but that would require many more changes.
> 
> Acked-by: Larry Finger <Larry.Finger@lwfinger.net>
> 
> 

Thanks!

I believe that the problem is the combination of "struct iw_event"
and the two buffers "u8 wpa_ie[255], rsn_ie[255];" and "u8 wps_ie[512];".
Just to document this better: if we ever decide to use a dynamic allocation,
I would allocate all of the above together.

	Arnd
