Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD76BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:00:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A8F720844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n3n8j092";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Iys07uah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A8F720844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UKekGqIUTTL+1ozhIQoWWY4xq3HBW+sodbHHPUh29uM=; b=n3n8j092XwK5T9DdWNQxQAFSs
	JKkrj0j1fKeTX+Qcfg1Ydeq3WPBSk1sOjKAjRDgnklO2QlvTWfwaiaFYdRZ69mQWmaTI5qNYOeC0o
	56p7bIj4Ls1HHFPsTj/6vTslDhKjDQFaDkUcW32iaAKwehT4V0B4Sr9iLZRI0rBu2pXZ+IdEijd6U
	tVoSCDYHeo+OgbenNGwCjvOoASpVNZJMlxKX1fw3/735imGMsoqD0ceoi+r4AhN5Fjc+KmUkOZ97i
	Q35YvgFjPhTYsRVN+NF65TKx5UXy8vEf6AUxKDbRDrPjzhaKnHLqHFyaBbSjoAL1x59Tfko//YoQT
	ukOEpp11Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt6Vl-000207-Ax; Mon, 11 Feb 2019 08:00:17 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt6Vi-0001zT-0P
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 08:00:15 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c612b8b0000>; Mon, 11 Feb 2019 00:00:11 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 11 Feb 2019 00:00:11 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 11 Feb 2019 00:00:11 -0800
Received: from localhost (10.124.1.5) by HQMAIL101.nvidia.com (172.20.187.10)
 with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Mon, 11 Feb 2019 08:00:10 +0000
Date: Mon, 11 Feb 2019 09:00:08 +0100
From: Thierry Reding <treding@nvidia.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [REGRESSION] drm/tegra: hdmi: tegra_hdmi_setup_audio: division
 by zero in kernel
Message-ID: <20190211080007.GA923@ulmo>
References: <87f8fd40b25e2842b547059a8d28295533e8c09c.camel@toradex.com>
MIME-Version: 1.0
In-Reply-To: <87f8fd40b25e2842b547059a8d28295533e8c09c.camel@toradex.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1549872011; bh=idFFGcNvkPEqR0gSGLueiKh/h7L0HHEloEkufk/hnoI=;
 h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
 MIME-Version:In-Reply-To:X-NVConfidentiality:User-Agent:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:
 Content-Disposition;
 b=Iys07uah2hpQdcENZ6IXma6q+xEUhtCebE2oYx2bmYTXp07E2Nv3R4Xel5zDtnbFS
 2X/0hCo0xzOGrwB05WRmgBn4TSMDQf8s9V12Tc+4I+JVJlyNXb7Mtpu395z6VbbZdG
 e9vHLz6smGmMV1wCjsgltQv/Nz7M3wx0KTOftsHCYIkNkDajS9omAUpHOa18R9+f/n
 bIhgoHrdPGLGMk+4PfSRYOz3lGm6m3sfikdU6kZNTBRuKlPnQSGHxwDpQjnT4uSkiI
 Csl1Fd6jLjsh3AuQRbRVbdLm31IOiHBQg/Fb+XpOq9M+kLI0BIObUv1dhreH1MpMAz
 RjX8cyGE9eQWQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_000014_068279_046CCF62 
X-CRM114-Status: GOOD (  13.19  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "alban.bedel@avionic-design.de" <alban.bedel@avionic-design.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============8222620694557647825=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--===============8222620694557647825==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 08, 2019 at 08:01:03PM +0000, Marcel Ziswiler wrote:
> Hi there
>=20
> I just stumbled over this one:
>=20
> [   31.026220] Division by zero in kernel.
> [   31.026238] CPU: 1 PID: 529 Comm: X Not tainted 5.0.0-rc5-next-
> 20190208-dirty #153
> [   31.026244] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
> [   31.026281] [<c01120cc>] (unwind_backtrace) from [<c010c92c>]
> (show_stack+0x10/0x14)
> [   31.026301] [<c010c92c>] (show_stack) from [<c0a7c5ac>]
> (dump_stack+0xb4/0xc8)
> [   31.026317] [<c0a7c5ac>] (dump_stack) from [<c0a7a7e4>]
> (Ldiv0+0x8/0x10)
> [   31.026337] [<c0a7a7e4>] (Ldiv0) from [<c0588758>]
> (tegra_hdmi_setup_audio+0x1ac/0xed0)
> [   31.026353] [<c0588758>] (tegra_hdmi_setup_audio) from [<c0589a68>]
> (tegra_hdmi_encoder_enable+0x5ec/0x2a20)
> [   31.026379] [<c0589a68>] (tegra_hdmi_encoder_enable) from
> [<c054415c>] (drm_atomic_helper_commit_modeset_enables+0x10c/0x220)
> [   31.026397] [<c054415c>] (drm_atomic_helper_commit_modeset_enables)
> from [<c054449c>] (drm_atomic_helper_commit_tail_rpm+0x24/0x6c)
> [   31.026412] [<c054449c>] (drm_atomic_helper_commit_tail_rpm) from
> [<c054431c>] (commit_tail+0x40/0x6c)
> [   31.026427] [<c054431c>] (commit_tail) from [<c054440c>]
> (drm_atomic_helper_commit+0xbc/0x128)
> [   31.026443] [<c054440c>] (drm_atomic_helper_commit) from
> [<c0547260>] (restore_fbdev_mode_atomic+0x160/0x1cc)
> [   31.026457] [<c0547260>] (restore_fbdev_mode_atomic) from
> [<c0547420>] (drm_fb_helper_pan_display+0xc4/0x1d0)
> [   31.026481] [<c0547420>] (drm_fb_helper_pan_display) from
> [<c04b0250>] (fb_pan_display+0x9c/0x118)
> [   31.026498] [<c04b0250>] (fb_pan_display) from [<c04b0fdc>]
> (do_fb_ioctl+0x4b0/0x7cc)
> [   31.026514] [<c04b0fdc>] (do_fb_ioctl) from [<c027e688>]
> (do_vfs_ioctl+0xac/0x8f8)
> [   31.026527] [<c027e688>] (do_vfs_ioctl) from [<c027ef08>]
> (ksys_ioctl+0x34/0x60)
> [   31.026540] [<c027ef08>] (ksys_ioctl) from [<c0101000>]
> (ret_fast_syscall+0x0/0x54)
> [   31.026546] Exception stack(0xcba59fa8 to 0xcba59ff0)
> [   31.026559] 9fa0:                   001527a8 00152278 0000000a
> 00004606 00152808 00000000
> [   31.026572] 9fc0: 001527a8 00152278 0015b368 00000036 b6f20961
> 0000000a bedb5dd4 00000000
> [   31.026581] 9fe0: b6af7098 bedb5b1c b6af4603 b6cdb67c
> [   31.026586] Division by zero in kernel.
> [   31.026595] CPU: 1 PID: 529 Comm: X Not tainted 5.0.0-rc5-next-
> 20190208-dirty #153
> [   31.026600] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
> [   31.026615] [<c01120cc>] (unwind_backtrace) from [<c010c92c>]
> (show_stack+0x10/0x14)
> [   31.026629] [<c010c92c>] (show_stack) from [<c0a7c5ac>]
> (dump_stack+0xb4/0xc8)
> [   31.026640] [<c0a7c5ac>] (dump_stack) from [<c0a7a7e4>]
> (Ldiv0+0x8/0x10)
> [   31.026654] [<c0a7a7e4>] (Ldiv0) from [<c05887ac>]
> (tegra_hdmi_setup_audio+0x200/0xed0)
> [   31.026667] [<c05887ac>] (tegra_hdmi_setup_audio) from [<c0589a68>]
> (tegra_hdmi_encoder_enable+0x5ec/0x2a20)
> [   31.026684] [<c0589a68>] (tegra_hdmi_encoder_enable) from
> [<c054415c>] (drm_atomic_helper_commit_modeset_enables+0x10c/0x220)
> [   31.026700] [<c054415c>] (drm_atomic_helper_commit_modeset_enables)
> from [<c054449c>] (drm_atomic_helper_commit_tail_rpm+0x24/0x6c)
> [   31.026715] [<c054449c>] (drm_atomic_helper_commit_tail_rpm) from
> [<c054431c>] (commit_tail+0x40/0x6c)
> [   31.026729] [<c054431c>] (commit_tail) from [<c054440c>]
> (drm_atomic_helper_commit+0xbc/0x128)
> [   31.026743] [<c054440c>] (drm_atomic_helper_commit) from
> [<c0547260>] (restore_fbdev_mode_atomic+0x160/0x1cc)
> [   31.026755] [<c0547260>] (restore_fbdev_mode_atomic) from
> [<c0547420>] (drm_fb_helper_pan_display+0xc4/0x1d0)
> [   31.026770] [<c0547420>] (drm_fb_helper_pan_display) from
> [<c04b0250>] (fb_pan_display+0x9c/0x118)
> [   31.026785] [<c04b0250>] (fb_pan_display) from [<c04b0fdc>]
> (do_fb_ioctl+0x4b0/0x7cc)
> [   31.026797] [<c04b0fdc>] (do_fb_ioctl) from [<c027e688>]
> (do_vfs_ioctl+0xac/0x8f8)
> [   31.026809] [<c027e688>] (do_vfs_ioctl) from [<c027ef08>]
> (ksys_ioctl+0x34/0x60)
> [   31.026820] [<c027ef08>] (ksys_ioctl) from [<c0101000>]
> (ret_fast_syscall+0x0/0x54)
> [   31.026826] Exception stack(0xcba59fa8 to 0xcba59ff0)
> [   31.026837] 9fa0:                   001527a8 00152278 0000000a
> 00004606 00152808 00000000
> [   31.026850] 9fc0: 001527a8 00152278 0015b368 00000036 b6f20961
> 0000000a bedb5dd4 00000000
> [   31.026859] 9fe0: b6af7098 bedb5b1c b6af4603 b6cdb67c
>=20
> This has been observed on a Apalis T30 2GB running todays -next.
>=20
> Anybody knowing what is going on before I dig deeper?

What exactly was your setup like? I think the only way that this could
happen is if the sample_rate variable was 0, and I'm not sure how that
could happen. I remember testing this on Beaver without ever seeing a
crash, so I don't know what I overlooked.

Looking at the code it seems like the only way that it would happen is
if the format structure was never initialized, and it seems like it
actually is zeroed out and if nobody ever plays audio over HDMI it will
remain that way. But that means that HDMI would always crash, and that
is definitely not something that I've observed.

Can you specify what exactly your test case is and how I can reproduce?

Thierry

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxhK4MACgkQ3SOs138+
s6FX9Q/+OutA5S721H/nvoBN3mODpLMoFz1mRX6ie8cInENSpgwqYg1RDNrcsfNR
kePDAYzTdbWIzp8m0zNRqmckeSWlYFxZiNj5CSWMZHMShdGTUJ62CV/V5IZLFqsT
nKCXKW7l95SUuMznVk771Klv8GPA3RnIE1MlxyGWiaB9fE6bi00GbyEvlXJziC6d
EUGGupUlk2P+FbD3z+pTt7fGiAtZb7LyyBpzKiyhutJMP7KXZZphbKh0AehW6/wH
ZJefYU3VjB1Ew9OxjTvspISxQWNDOjrZlWwtpIGhpHm79XNwJUfDD4pk+iY09XFD
p1qUyVxA6m10DpTOopwK41sbdP/Cs8b3VtTYMUoyvh+8igU8vyBRp/EZeJ5d4dtP
NDY4Af7YbjHmF38mL/NpbxFDXbGdfszVFtpoM2DczH0S0S+yM+Woor15IHXYmoX8
SDZ4Xv5ypI+qy97OYb354WVizQg5oGoiMCaVITrr4d9OAmeSx9JcPQOf3p3mEp0I
4xWwwhGVxhEsFYZZnqW7lzOr/PE9g+Dem2yZz7TKb5+Gqhl7P39dsXlkBuxc11yf
ALBBSI3pP0E7/MoWM7LUm/NGoN31X33k5Svd1V8OOfS0IfWy/zy5cdXf+Y0h4Yns
6FZLp4Zxa4cads0O7LhJnPjrY5FLX+q3SqrWM5nZpQiI7IQ9CPA=
=BxOo
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--


--===============8222620694557647825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8222620694557647825==--

