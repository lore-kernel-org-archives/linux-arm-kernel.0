From: joe@perches.com (Joe Perches)
Date: Mon, 26 Mar 2018 13:28:56 -0700
Subject: [PATCH script] hwmon: Use octal not symbolic permissions
Message-ID: <1522096136.12357.21.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/hwmon is the most frequent user of symbolic permissions
like S_IRUGO in the kernel tree.

$ git grep -w -P "S_[A-Z]{5,5}" | \
  cut -f1 -d: | cut -f1-2 -d"/" | sed -r 's/[A-Za-z0-9_-]+\.[ch]$//' | \
  sort | uniq -c | sort -rn | head
   3862 drivers/hwmon
    814 drivers/scsi
    763 drivers/net
    242 drivers/infiniband
    184 drivers/staging
    181 drivers/usb
    158 fs/proc
    150 fs/xfs
    148 fs/
    142 drivers/misc

But using octal and not symbolic permissions is preferred by many
as it can be more readable.

https://lkml.org/lkml/2016/8/2/1945

Rather than converting these piecemeal, perhaps just do them all
at once via a trivial script like the below:

$ git grep -w -P --name-only "S_[A-Z]{5,5}" drivers/hwmon | \
  xargs ./scripts/checkpatch.pl -f --types=symbolic_perms --fix-inplace
$ git grep -w -P --name-only "S_[A-Z]{5,5}" drivers/hwmon | \
  xargs ./scripts/checkpatch.pl -f --types=symbolic_perms --fix-inplace

It's run twice because checkpatch only does 1 conversion per line
and there are some multiple instance lines.

This currently results in a 669 KB patch which is too large
to post but can be easily generated when appropriate.
