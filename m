From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Feb 2014 16:05:16 +0100
Subject: pci-mvebu driver on km_kirkwood
In-Reply-To: <20140221144708.48559045@skate>
References: <53039894.10905@keymile.com> <53074584.5010202@keymile.com>
 <20140221144708.48559045@skate>
Message-ID: <2193926.ls2teBqnfK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 February 2014 14:47:08 Thomas Petazzoni wrote:
> 
> > So I'd say this looks like a very promising approach. 
> 
> Indeed. However, I don't think this approach solves the entire problem,
> for two reasons:
> 
>  *) For small BARs that are not power-of-two sized, we may not want to
>     consume two windows, but instead consume a little bit more address
>     space. Using two windows to map a 96 KB BAR would be a waste of
>     windows: using a single 128 KB window is much more efficient.

definitely.
 
>  *) I don't know if the algorithm to split the BAR into multiple
>     windows is going to be trivial.

The easiest solution would be to special case 'size is between
128MB+1 and 192MB' if that turns out to be the most interesting
case. It's easy enough to make the second window smaller than 64MB
if we want.

If we want things to be a little fancier, we could use:

	switch (size) {
		case (SZ_32M+1) ... (SZ_32M+SZ_16M):
			size2 = size - SZ_32M;
			size -= SZ_32M;
			break;
		case (SZ_64M+1) ... (SZ_64M+SZ_32M):
			size2 = size - SZ_64M;
			size -= SZ_64M;
			break;
		case (SZ_128M+1) ... (SZ_128M+SZ_64M):
			size2 = size - SZ_128M;
			size -= SZ_128M;
			break;
	};


	Arnd
