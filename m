From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 02 May 2016 20:41:11 +0200
Subject: [PATCH] s5p-mfc: Don't try to put pm->clock if lookup failed
In-Reply-To: <1462210075-5320-1-git-send-email-javier@osg.samsung.com>
References: <1462210075-5320-1-git-send-email-javier@osg.samsung.com>
Message-ID: <2610031.B6nN8fjXyO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 May 2016 13:27:54 Javier Martinez Canillas wrote:
> Failing to get the struct s5p_mfc_pm .clock is a non-fatal error so the
> clock field can have a errno pointer value. But s5p_mfc_final_pm() only
> checks if .clock is not NULL before attempting to unprepare and put it.
> 
> This leads to the following warning in clk_put() due s5p_mfc_final_pm():
> 

Better assign the pointer to NULL in case of a non-fatal error
return code. That way, the reader doesn't have to wonder why you
have the IS_ERR_OR_NULL() check here.

	Arnd
