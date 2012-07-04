From: javier.martin@vista-silicon.com (javier Martin)
Date: Wed, 4 Jul 2012 09:48:13 +0200
Subject: Clock problems in i.MX27 Visstrim M10 (linux-3.5-rc5).
In-Reply-To: <CAOMZO5CeGKJ6kERaCkNE0Cpy2X78CUN_-au5Q+cCtLLjtNXMDg@mail.gmail.com>
References: <CACKLOr0z13sMQhb14YpDp7UtwfhVoqRAMOJCA+geapq=Lh7VuQ@mail.gmail.com>
 <CAOMZO5CeGKJ6kERaCkNE0Cpy2X78CUN_-au5Q+cCtLLjtNXMDg@mail.gmail.com>
Message-ID: <CACKLOr1oeci84Fs7HTRD2Myie8zjKExA15mxM3z7dkq8QfvDmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 3 July 2012 15:13, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Javier,
>
> On Tue, Jul 3, 2012 at 8:09 AM, javier Martin
> <javier.martin@vista-silicon.com> wrote:
>> Hi,
>> I've found the following problems in linux-3.5-rc5
>> (6887a4131da3adaab011613776d865f4bcfb5678) in our Visstrim M10 board:
>
> Could you please try the two attached patches?
>
> They should fix the dma and mx2-camera issues.
>
> I will try to look at the ssi problem, but my mx27pdk board still does
> not have audio supported.
>
> Regards,
>

thanks for the patches. The first one solves the issue with the audio.
Now I can do an aplay properly too.

However, second patch for the mx2-camera seems that it's not right
yet. I get a timeout here:

static int mx27_camera_emma_prp_reset(struct mx2_camera_dev *pcdev)
{
	u32 cntl;
	int count = 0;

	cntl = readl(pcdev->base_emma + PRP_CNTL);
	writel(PRP_CNTL_SWRST, pcdev->base_emma + PRP_CNTL);
	while (count++ < 100) {
		if (!(readl(pcdev->base_emma + PRP_CNTL) & PRP_CNTL_SWRST))
			return 0;
		barrier();
		udelay(1);
	}

	return -ETIMEDOUT;
}

Keeping this in mind I infer that probably emma clocks have not been
properly enabled.


-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
