From: stephen@networkplumber.org (Stephen Hemminger)
Date: Tue, 10 Oct 2017 10:19:21 -0700
Subject: [PATCH v2] xdp: Sample xdp program implementing ip forward
In-Reply-To: <1507620532-25804-2-git-send-email-Christina.Jacob@cavium.com>
References: <1507620532-25804-1-git-send-email-Christina.Jacob@cavium.com>
 <1507620532-25804-2-git-send-email-Christina.Jacob@cavium.com>
Message-ID: <20171010101921.30136d48@shemminger-XPS-13-9360>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Oct 2017 12:58:52 +0530
Christina Jacob <christina.jacob.koikara@gmail.com> wrote:

> +/* Get the mac address of the interface given interface name */
> +static long *getmac(char *iface)
> +{
> +	int fd;
> +	struct ifreq ifr;
> +	long *mac = NULL;
> +
> +	fd = socket(AF_INET, SOCK_DGRAM, 0);
> +	ifr.ifr_addr.sa_family = AF_INET;
> +	strncpy(ifr.ifr_name, iface, IFNAMSIZ - 1);
> +	ioctl(fd, SIOCGIFHWADDR, &ifr);
> +	mac = (long *)ifr.ifr_hwaddr.sa_data;
> +	close(fd);
> +	return mac;

Always check return value of ioctl.
You are assuming sizeof(long) > 6 bytes.
Also the byte order.
